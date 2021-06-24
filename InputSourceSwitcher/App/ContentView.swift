import KeyboardShortcuts
import SwiftUI

// [ContentView]
struct ContentView: View {
    @ObservedObject var MyInputSources: InputSourcesModel = InputSourcesModel()

    var body: some View {
        VStack {
            TopOptionView(MyInputSources: MyInputSources)

            Divider()

            SwitcherView(MyInputSources: MyInputSources)
        }
        .padding()
    }
}

struct TopOptionView: View {
    @ObservedObject var MyInputSources: InputSourcesModel
    @Environment(\.openURL) var openURL

    var body: some View {
        HStack {
            Button("About") {
                print(Time() + "[Button] About clicked")

                // link to open `AboutView` window
                // `Target -> Info -> URL Types -> URL Schemes`://Viewer
                if let url = URL(string: "SourceSwitcherAbout://Viewer") {
                    openURL(url)
                }
            }
            .keyboardShortcut("i", modifiers: .command)

            Button("Update") {
                print(Time() + "[Button] Update clicked")

                MyInputSources.Update() // get new InputSources from system and save KeyboardShortcuts at the same time
            }
            .keyboardShortcut("u", modifiers: .command)

            Button("Reset") {
                print(Time() + "[Button] Reset clicked")

                MyInputSources.Reset() // reset KeyboardShortcuts and InputSources
            }
            .keyboardShortcut("r", modifiers: .command)

            Button("Quit") {
                print(Time() + "[Button] Quit clicked")

                NSApplication.shared.terminate(self) // quit app == cmd Q
            }
        }
        .padding()
    }
}

struct SwitcherView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

    var body: some View {
        // Use right alignment to put `record shortcut` who are all the same size to make SwitcherView orderly
        VStack(alignment: .trailing) {
            ForEach(MyInputSources.inputSources) { inputSource in
                HStack {
                    Button("Switch to \(inputSource.name)") {
                        print(Time() + "[Button] Switch to \(inputSource.name) Clicked")

                        MyInputSources.SwitchInputSource(to: inputSource.name)
                    }

                    KeyboardShortcuts.Recorder(for: KeyboardShortcuts.Name(inputSource.name))
                        .onAppear {
                            KeyboardShortcuts.onKeyDown(for: KeyboardShortcuts.Name(inputSource.name)) {
                                print(Time() + "[KeyboardShortcuts] shortcut of \(inputSource.name) down")

                                MyInputSources.SwitchInputSource(to: inputSource.name)
                            }
                        }
                }
            }
        }
        .padding()
    }
}
