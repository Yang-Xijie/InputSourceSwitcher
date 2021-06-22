import KeyboardShortcuts
import SwiftUI

// [ContentView]
struct ContentView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

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
        .frame(idealWidth: 300,maxWidth: .infinity, idealHeight: 200, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ )
    }
}

struct TopOptionView: View {
    @ObservedObject var MyInputSources: InputSourcesModel
    @Environment(\.openURL) var openURL

    var body: some View {
        HStack {
            Button("About") {
                // `Target -> Info -> URL Types -> URL Schemes`://Viewer
                if let url = URL(string: "SourceSwitcherAbout://Viewer") {
                    openURL(url)
                }
            }
            Button("Reset") {
                print("[Button] Reset clicked")
                MyInputSources.Reset() // reset InputSources and KeyboardShortcuts
            }
            Button("Quit") {
                print("[Button] Quit clicked")
                NSApplication.shared.terminate(self) // quit app == cmd Q
            }
        }
    }
}

struct SwitchButtonView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

    var body: some View {
        VStack {
            ForEach(MyInputSources.currentInputSources) { inputSource in
                Button("Switch to \(inputSource.name)") {
                    print("[UI] Button Switch to \(inputSource.name) Clicked!")

                    MyInputSources.SwitchInputSource(to: inputSource.name)
                }
            }
        }
    }
}

struct ShortcutsView: View {
    @ObservedObject var MyInputSources: InputSourcesModel

    var body: some View {
        VStack {
            // show switch buttons
            ForEach(MyInputSources.currentInputSources) { inputSource in
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
    }
}
