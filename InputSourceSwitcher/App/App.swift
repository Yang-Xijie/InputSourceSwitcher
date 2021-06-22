import SwiftUI

@main
struct SourceSwitcherApp: App {
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
                }

                Button("Support") {
                    print("[Menu Bar] App -> Support")
                }
            }

            CommandGroup(replacing: .help) { // Help
                Button("Help") {
                    print("[Menu Bar] Help -> Help")
                }
                .keyboardShortcut("?", modifiers: .command)
            }
        }
        
        WindowGroup{ // other scene
            Text("About").padding()
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "*"))
        
        WindowGroup{ // other scene
            Text("HAHA").padding()
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "*"))
    }
}
