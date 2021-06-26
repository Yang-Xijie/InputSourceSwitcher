import SwiftUI

@main
struct SourceSwitcherApp: App {
    // make this app a menu bar app
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // add link to AboutView
    @Environment(\.openURL) var openURL

    var body: some Scene {
        // [another window]
        Settings {
            EmptyView()
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
        statusBarItem?.button?.image = NSImage(
            systemSymbolName: "keyboard",
            accessibilityDescription: "keyboard")?
            .withSymbolConfiguration(NSImage.SymbolConfiguration(textStyle: .body, scale: .large))
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
