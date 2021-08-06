import Foundation
import KeyboardShortcuts

struct InputSources {
    var inputSources: [InputSource] = []
    let inputSources_key: String = "InputSources"

    // MARK: - init

    init() {
        if UserDefaults.isFirstLaunch() {
            LoadNewInputSourcesFromSystem()
            // FIXME: If you don't give `Accessiblity` to this app in `System Preferences -> Security` before you open this app for the first time, then no input source will appear. User can `Reset` to solve that problem.
        } else {
            // when the app restart, use Update() to clear unwanted global shortcuts
            Update()
        }
    }

    // Once `inputSources` changes, call this function.
    func StoreInputSourcesToUserDefault() {
        do {
            let data = try JSONEncoder().encode(inputSources)
            UserDefaults.standard.set(data, forKey: inputSources_key) // save inputSources
        } catch {
            print("[StoreInputSourcesToUserDefault Error] \(error)")
        }
    }

    func GetInputSourcesFromUserDefaults() -> [InputSource] {
        do {
            let storedData = UserDefaults.standard.data(forKey: inputSources_key) // get inputSources
            let arr = try JSONDecoder().decode([InputSource].self, from: storedData!)
            return arr
        } catch {
            print("[GetInputSourcesFromUserDefaults Error] \(error)")
            return []
        }
    }

    // MARK: - functions that change `inputSources`

    /// Update currentInputSources in model.
    mutating func LoadNewInputSourcesFromSystem() {
        inputSources = GetNewInputSourcesFromSystem()
        StoreInputSourcesToUserDefault()
    }

    /// `Update`: **re-get** Input Sources from system and **preserve**  shortcut settings at the same time.
    mutating func Update() {
        // [Analysis]
        // [user did't change System Input Sources]
        // just refresh inputSources
        // [user added System Input Sources]
        // just refresh inputSources
        // [user removes System Input Sources]
        // Firstly, find the removed Input Sources
        // Then, use their names to reset their shortcuts (to avoid situation of unwanted global shortcuts)
        // Next, refresh inputSources

        // Firstly, find the removed Input Sources
        let originalInputSources: [InputSource] = GetInputSourcesFromUserDefaults()
        let newInputSources: [InputSource] = GetNewInputSourcesFromSystem()

        var original: [String] = []
        for item in originalInputSources {
            original.append(item.name)
        }

        var new: [String] = []
        for item in newInputSources {
            new.append(item.name)
        }

        let inputSourcesToResetShortcut: Set<String> = Set(original).subtracting(Set(new))

//        print("[Model Debug]\n\toriginalInputSources:\(originalInputSources)\n\tnewInputSources:\(newInputSources)\n\tinputSourcesToResetShortcut:\(inputSourcesToResetShortcut)")

        // Then, use their names to reset their shortcuts

        if inputSourcesToResetShortcut != Set<String>() {
            for inputSource in inputSourcesToResetShortcut {
                KeyboardShortcuts.reset(KeyboardShortcuts.Name(inputSource))
                print("[KeyboardShortcuts] reset \(inputSource)")
            }
        }

        // Next, refresh inputSources
        LoadNewInputSourcesFromSystem()
    }

    /// `Reset`: **reset** the shortcut settings and **re-get** Input Sources from system.
    mutating func Reset() {
        for inputSource in inputSources {
            KeyboardShortcuts.reset(KeyboardShortcuts.Name(inputSource.name))
            print("[KeyboardShortcuts] reset \(inputSource.name)")
        }

        LoadNewInputSourcesFromSystem()
    }

    // MARK: - functions concerning Applescript

    func GetNewInputSourcesFromSystem() -> [InputSource] {
        return UseApplescriptToGetSystemInputSourcesInMenubar()
    }

    func SwitchInputSource(to inputSourceName: String) {
        UseApplescriptToSwitchInputSource(to: inputSourceName)
    }
}
