//
//  InputSourceSwitcherApp.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import SwiftUI

@main
struct InputSourceSwitcherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        .commands {
            // Clear default items
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .newItem) {}

            // customized items
            CommandGroup(replacing: .pasteboard) {
                Button("Reset") {
                    print("[Menu Bar] Reset -> Reset")
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
