import SwiftUI
import UserNotifications

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
            rootView: ContentView())
        popover.contentViewController?.view.window?.makeKey()

        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.image = NSImage(
            systemSymbolName: "keyboard",
            accessibilityDescription: "keyboard")?
            .withSymbolConfiguration(NSImage.SymbolConfiguration(textStyle: .body, scale: .large))
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))

        // When starting the app, show the popover.
        // If don't do like this, open the app and shortcuts will not work until click the icon on the menu bar.
        // FIXME: If the user hides the menu bar (System Preferences -> Dock & Menu Bar -> Dock & Menu Bar -> Automatically hide and show the menu bar -> checked), the popover will appear on the top left corner of the screen, instead of appearing below the menu bar icon.
        if
//          true // debug
            UserDefaults.isFirstLaunch()
        {
            // first launch - show the window
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if let button = self.statusBarItem?.button {
                    self.popover.show(
                        relativeTo: button.bounds,
                        of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        } else {
            // second and after launch - activate the window to start `KeyboardShortcuts`, but not show the window
            if let button = statusBarItem?.button {
                popover.show(
                    relativeTo: button.bounds,
                    of: button, preferredEdge: NSRectEdge.minY)
            }
        }

        // send notifications on macOS
        RequestNotificationCenterAuthorization()
    }

    func RequestNotificationCenterAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                print("[NotificationCenter.requestAuthorization] error - \(error)")
            }
        }
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
