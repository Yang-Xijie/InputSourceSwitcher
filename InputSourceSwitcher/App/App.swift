import SwiftUI

@main
struct SourceSwitcherApp: App {
    // use @StateObject to init an ObservableObject
    @StateObject var MyInputSources = InputSourcesModel()
    @Environment(\.openURL) var openURL

    var body: some Scene {
        WindowGroup {
            ContentView(MyInputSources: MyInputSources)
        }
        .commands {
            // [clear macOS default items]
            CommandGroup(replacing: .undoRedo) {} // Undo Redo
            CommandGroup(replacing: .newItem) {} // New Window
            CommandGroup(replacing: .help) {} // Help

            // [customized items]
            CommandGroup(replacing: .pasteboard) { // Cut Copy Paste...
                Button("Reset") {
                    print("[Menu Bar] Reset -> Reset")
                    MyInputSources.Reset()
                }
                .keyboardShortcut("r", modifiers: .command)
            }

            CommandGroup(replacing: .appInfo) { // About
                Button("About") {
                    print("[Menu Bar] App -> About")
                    // `Target -> Info -> URL Types -> URL Schemes`://Viewer
                    if let url = URL(string: "SourceSwitcherAbout://Viewer") {
                        openURL(url)
                    }
                }
            }
        }

        // [another window]
        WindowGroup("SourceSwitcherAbout") {
            AboutView()
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "SourceSwitcherAbout")) // String including part of `URL Schemes`
    }
}
