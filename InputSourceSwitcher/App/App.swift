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
    @ObservedObject var MyInputSources = InputSourcesModel() // use @StateObject will induce some problems...

    var popover = NSPopover()
    var statusBarItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Specifies the behavior of the popover.
        // transient - The system will close the popover when the user interacts with a user interface element outside the popover.
        popover.behavior = .transient
        popover.animates = false
        // The view controller that manages the content of the popover.
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(
            rootView: ContentView(MyInputSources: MyInputSources))
        popover.contentViewController?.view.window?.makeKey()
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.image = NSImage(
            systemSymbolName: "keyboard",
            accessibilityDescription: "keyboard")?
            .withSymbolConfiguration(NSImage.SymbolConfiguration(textStyle: .body, scale: .large))
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))

        // When starting the app, open show the popover. If not do like this,  open the app and shortcuts will not work.
        print(popover.isShown) // false
        // FIXME: It's a tricky workaround. I tried lots of methods, but the window not appears when start...
        if let button = statusBarItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        print(popover.isShown) // true (but soon it changes to false)
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
        print("[Popover before toggling] popover.isShown: \(popover.isShown)")
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
        print("[Popover after toggling] popover.isShown: \(popover.isShown)")
    }
}
