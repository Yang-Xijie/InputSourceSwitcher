import Foundation
import KeyboardShortcuts

class InputSourcesModel: ObservableObject {
    // MARK: - Create Model

    @Published private var model: InputSources = InputSourcesModel.createMyInputSources()

    private static func createMyInputSources() -> InputSources {
        print("[Model] createMyInputSources()")

        return InputSources()
    }

    // MARK: - Access to Data in Model

    var inputSources: [InputSource] {
        model.inputSources
    }

    // MARK: - Deal with Intents from View

    /// `Reset`: **reset** the shortcut settings and **re-get** Input Sources from system.
    func Reset() {
        model.Reset()

        print("[Model] Reset()")
    }

    /// `Update`: **re-get** Input Sources from system and **preserve**  shortcut settings at the same time.
    func Update() {
        model.Update()

        print("[Model] Update()")
    }

    func SwitchInputSource(to inputSourceName: String) {
        model.SwitchInputSource(to: inputSourceName)

        print("[Model] Switch to InputSource\(inputSourceName)")
    }
}
