import Foundation

func ToggleDarkMode() {
    let ToggleDarkModeScript = """
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

    if let script = NSAppleScript(source: ToggleDarkModeScript) {
        var error: NSDictionary?
        script.executeAndReturnError(&error)
        if let err = error {
            print(err)
        }
    }
}

func SwitchInputSource(to sourceName: String) {
    let applesript = """
    tell application "System Events"
        tell process "TextInputMenuAgent"
            click menu item "\(sourceName)" of menu 1 of menu bar item 1 of menu bar 2
            click menu bar item 1 of menu bar 2
        end tell
    end tell
    """

    if let script = NSAppleScript(source: applesript) {
        var error: NSDictionary?
        script.executeAndReturnError(&error)
        if let err = error {
            print(err)
        }
    }
}
