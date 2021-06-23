import Foundation

func UseApplescriptToGetSystemInputSourcesInMenubar() -> [InputSource] {
    let applesript = """
    tell application "System Events"
        tell process "TextInputMenuAgent"
            get the name of menu item of menu 1 of menu bar item 1 of menu bar 2
        end tell
    end tell
    """

    if let script = NSAppleScript(source: applesript) {
        var error: NSDictionary?
        let descriptor = script.executeAndReturnError(&error)
        /// descriptor: <NSAppleEventDescriptor: [ 'utxt'("Pinyin - Simplified"), 'utxt'("ABC"), 'utxt'("Hiragana"), 'msng', 'utxt'("Handwriting - Simplified"), 'msng', 'utxt'("Show Emoji & Symbols"), 'utxt'("Show Keyboard Viewer"), 'msng', 'utxt'("Show Input Source Name"), 'msng', 'utxt'("Open Keyboard Preferences…") ]>
        if let err = error {
            print(Time() + "[Applescript] NSAppleScript.executeAndReturnError(): \(err)")
        } else {
            var currentInputSources: [InputSource] = []
            for i in 1 ... descriptor.numberOfItems {
                if let inputSource = descriptor.atIndex(i)?.stringValue {
                    currentInputSources.append(InputSource(name: inputSource, id: i))
                } else {
                    print(Time() + "[Applescript] Got \(currentInputSources.count) input sources from menu bar.")
                    return currentInputSources
                }
            }
        }
    } else {
        print(Time() + "[Applescript] NSAppleScript.init()")
    }
    return []
}

func UseApplescriptToSwitchInputSource(to inputSourceName: String) {
    let applesript = """
    tell application "System Events"
        tell process "TextInputMenuAgent"
            click menu item "\(inputSourceName)" of menu 1 of menu bar item 1 of menu bar 2
            click menu bar item 1 of menu bar 2
        end tell
    end tell
    """

    if let script = NSAppleScript(source: applesript) {
        var error: NSDictionary?
        script.executeAndReturnError(&error)
        if let err = error {
            print(Time() + "[Applescript] NSAppleScript.executeAndReturnError(): \(err)")
        }
    } else {
        print(Time() + "[Applescript] NSAppleScript.init()")
    }
}
