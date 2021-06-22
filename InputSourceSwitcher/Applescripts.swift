import Foundation

let source = """
      tell application "System Events"
          tell appearance preferences
              if (dark mode) = false then
                  set dark mode to true
              else
                  set dark mode to false
              end if
          end tell
      end tell
"""

func ToggleNightMode() {
    if let script = NSAppleScript(source: source) {
        var error: NSDictionary?
        script.executeAndReturnError(&error)
        if let err = error {
            print(err)
        }
    }
}
