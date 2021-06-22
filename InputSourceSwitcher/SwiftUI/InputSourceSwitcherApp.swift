//
//  InputSourceSwitcherApp.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import SwiftUI

@main
struct InputSourceSwitcherApp: App {
    @StateObject var MyInputSources = InputSourcesModel()

    var body: some Scene {
        WindowGroup {
            ContentView(MyInputSources: MyInputSources)
        }

        .commands {
            // Clear default items
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .newItem) {}

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
