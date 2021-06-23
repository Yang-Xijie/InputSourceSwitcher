import KeyboardShortcuts
import SwiftUI

// [ContentView]
struct ContentView: View {
    @ObservedObject var MyInputSources: InputSourcesModel = InputSourcesModel()

    var body: some View {
        VStack {
            TopOptionView(MyInputSources: MyInputSources)
            Divider()
            HStack {
                SwitchButtonView(MyInputSources: MyInputSources)
                ShortcutsView(MyInputSources: MyInputSources)
            }
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
                print("[Button] About clicked")

                // link to open `AboutView` window
                // `Target -> Info -> URL Types -> URL Schemes`://Viewer
                if let url = URL(string: "SourceSwitcherAbout://Viewer") {
                    openURL(url)
                }
            }

            Button("Update") {
                print("[Button] Update clicked")

                MyInputSources.Update() // get new InputSources from system and save KeyboardShortcuts at the same time
            }

            Button("Reset") {
                print("[Button] Reset clicked")

                MyInputSources.Reset() // reset KeyboardShortcuts and InputSources
            }

            Button("Quit") {
                print("[Button] Quit clicked")

                NSApplication.shared.terminate(self) // quit app == cmd Q
            }
        }
        .padding()
    }
}

struct SwitchButtonView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

    var body: some View {
        VStack {
            ForEach(MyInputSources.inputSources) { inputSource in
                Button("Switch to \(inputSource.name)") {
                    print("[UI] Button Switch to \(inputSource.name) Clicked!")

                    MyInputSources.SwitchInputSource(to: inputSource.name)
                }
            }
        }
        .padding()
    }
}

struct ShortcutsView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

    var body: some View {
        VStack {
            // show switch buttons
            ForEach(MyInputSources.inputSources) { inputSource in
                HStack {
                    let shortcut = KeyboardShortcuts.Name(inputSource.name)

                    HStack(alignment: .firstTextBaseline) {
                        KeyboardShortcuts.Recorder(for: shortcut)
                            .padding(.trailing, 10)
                    }
                    .onAppear {
                        KeyboardShortcuts.onKeyDown(for: shortcut) {
                            print("[Shortcuts] shortcut of \(inputSource.name) down")
                            MyInputSources.SwitchInputSource(to: inputSource.name)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
