import SwiftUI

@main
struct InputSourceSwitcherApp: App {
    // use @StateObject to init an ObservableObject
    @StateObject var MyInputSources = InputSourcesModel()

    var body: some Scene {
        WindowGroup {
            ContentView(MyInputSources: MyInputSources)
        }
        .commands {
            // clear macOS default items
            CommandGroup(replacing: .undoRedo) {} // Undo Redo
            CommandGroup(replacing: .newItem) {} // New Window

            // customized items
            CommandGroup(replacing: .pasteboard) {
                Button("Reset") {
                    print("[Menu Bar] Reset -> Reset")
                    MyInputSources.Reset()
                }
                .keyboardShortcut("r", modifiers: .command)
            }

            CommandGroup(replacing: .appInfo) {
                Button("About") {
                    print("[Menu Bar] App -> About")
                }

                Button("Support") {
                    print("[Menu Bar] App -> Support")
                }
            }

            CommandGroup(replacing: .help) {
                Button("Help") {
                    print("[Menu Bar] Help -> Help")
                }
                .keyboardShortcut("?", modifiers: .command)
            }
        }
    }
}
