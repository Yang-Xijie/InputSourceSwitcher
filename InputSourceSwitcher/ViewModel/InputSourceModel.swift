import Foundation
import KeyboardShortcuts

class InputSourcesModel: ObservableObject {
    // MARK: - Create Model

    @Published private var model: InputSources = InputSourcesModel.createMyInputSources()

    private static func createMyInputSources() -> InputSources {
        // TODO: add
        return InputSources()
    }

    // MARK: - Access to Data in Model

    var inputSources: [InputSource] {
        model.inputSources
    }

    // MARK: - Deal with Intents from View

    /// `Reset`: **reset** the shortcut settings and **re-get** Input Sources from system.
    func Reset() {
        for inputSource in model.inputSources {
            KeyboardShortcuts.reset(KeyboardShortcuts.Name(inputSource.name))
            print("[KeyboardShortcuts] reset \(inputSource.name)")
        }

        model.LoadNewInputSourcesFromSystem()

        print("[Model] Reset()")
    }

    /// `Update`: **re-get** Input Sources from system and **save**  shortcut settings at the same time.
    func Update() {
        // [Analysis]
        // [user did't change System Input Sources]
        // just refresh InputSourcesModel
        // [user added System Input Sources]
        // just refresh InputSourcesModel
        // [user removes System Input Sources]
        // Firstly, find the removed Input Sources
        // Then, use their names to reset their shortcuts (to avoid situation of unwanted global shortcuts)
        // Next, refresh InputSourcesModel

        // Firstly, find the removed Input Sources
        let originalInputSources: [InputSource] = model.inputSources
        let newInputSources: [InputSource] = model.GetNewInputSourcesFromSystem()

        var original: [String] = []
        for item in originalInputSources {
            original.append(item.name)
        }

        var new: [String] = []
        for item in newInputSources {
            new.append(item.name)
        }

        let inputSourcesToResetShortcut: Set<String> = Set(original).subtracting(Set(new))

        print("[Model Debug]\n\toriginalInputSources:\(originalInputSources)\n\tnewInputSources:\(newInputSources)\n\tinputSourcesToResetShortcut:\(inputSourcesToResetShortcut)\n")

        // Then, use their names to reset their shortcuts

        if inputSourcesToResetShortcut != Set<String>() {
            for inputSource in inputSourcesToResetShortcut {
                KeyboardShortcuts.reset(KeyboardShortcuts.Name(inputSource))
                print("[KeyboardShortcuts] reset \(inputSource)")
            }
        }

        // Next, refresh InputSourcesModel
        model.LoadNewInputSourcesFromSystem()

        print("[Model] Update()")
    }

    func Restart() {
        print("[Model] Restart")
    }

    func InsertInputSource(inputSourceName: String, id: Int) {
        model.InsertInputSource(name: inputSourceName, id: id)

        print("[Model] InsertInputSource(\(inputSourceName)")
    }

    func SwitchInputSource(to inputSourceName: String) {
        model.SwitchInputSource(to: inputSourceName)

        print("[Model] Switch to InputSource\(inputSourceName)")
    }
}
