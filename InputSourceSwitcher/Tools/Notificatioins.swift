import Cocoa

import UserNotifications

func PushNotification_DidSwitchInputSource(to inputsourceName: String) {
    // Create the notification and setup information
    let content = UNMutableNotificationContent()
    content.title = "\(inputsourceName)"
    content.body = "Successfully switched."

    // Create the request
    let uuidString = UUID().uuidString // TODO: not clear
    let request = UNNotificationRequest(
        identifier: uuidString,
        content: content,
        trigger: .none)

    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { error in
        if error != nil {
            print("[PushNotification_DidSwitchInputSource] Error")
        } else {
            // Successfully
            print("[PushNotification_DidSwitchInputSource] Successfully pushed.")
        }
    }
}
