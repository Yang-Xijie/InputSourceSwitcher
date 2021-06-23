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

        model.GetNewInputSourcesFromSystem()
        print("[Model] Reset()")
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
