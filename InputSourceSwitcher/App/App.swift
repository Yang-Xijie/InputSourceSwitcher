import SwiftUI

@main
struct SourceSwitcherApp: App {
    // make this app a menu bar app
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // add link to AboutView
    @Environment(\.openURL) var openURL

    var body: some Scene {
        // [another window]
        WindowGroup("SourceSwitcherAbout") {
            AboutView()
        }
        // add link to AboutView
        .handlesExternalEvents(matching: Set(arrayLiteral: "SourceSwitcherAbout")) // String including part of `URL Schemes`
        // manage menu bar commands
        .commands {
            // [clear macOS default items]
            CommandGroup(replacing: .undoRedo) {} // Undo Redo
            CommandGroup(replacing: .newItem) {} // New Window
            CommandGroup(replacing: .help) {} // Help

            // TODO: Add cmd R
//            // [customized items]
//            CommandGroup(replacing: .pasteboard) { // Cut Copy Paste...
//                Button("Reset") {
//                    print("[Menu Bar] Reset -> Reset")
//                    MyInputSources.Reset()
//                }
//                .keyboardShortcut("r", modifiers: .command)
//            }

            // replace system menu bar `About` to my `AboutView`
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
    }
}

// make this app a menu bar app
// refer to: https://github.com/zaferarican/menubarpopoverswiftui2
// LICENSE: https://github.com/zaferarican/menubarpopoverswiftui2/blob/master/LICENSE
class AppDelegate: NSObject, NSApplicationDelegate {
    @ObservedObject var MyInputSources: InputSourcesModel = InputSourcesModel() // use @StateObject will induce some problems...

    var popover = NSPopover()
    var statusBarItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.behavior = .transient
        popover.animates = false
        popover.contentViewController = NSViewController()
        // Edited
        popover.contentViewController?.view = NSHostingView(rootView: ContentView(MyInputSources: MyInputSources))
        popover.contentViewController?.view.window?.makeKey()
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.title = "SwitchInputSource" // TODO: change it to a icon
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
    }

    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }

    @objc func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}