import Foundation
import KeyboardShortcuts

class InputSourcesModel: ObservableObject {
    // MARK: - Create Model

    @Published private var model: InputSources = InputSourcesModel.createMyInputSources()

    private static func createMyInputSources() -> InputSources {
        return InputSources()
    }

    // MARK: - Access to Data of Model

    var currentInputSources: [InputSource] {
        model.currentInputSources
    }

    // MARK: - Deal with Intents from View

    func Reset() {
        model.Reset()
        for inputSource in model.currentInputSources {
            KeyboardShortcuts.reset(KeyboardShortcuts.Name(inputSource.name))
        }

        print("[Model] Reset()")
    }

    func InsertInputSourse(name: String, id: Int) {
        model.InsertInputSource(name: name, id: id)

        print("[Model] InsertInputSource(\(name)")
    }

    func SwitchInputSource(to sourceName: String) {
        model.SwitchInputSource(to: sourceName)
        
        print("[Model] Switch to InputSource\(sourceName)")
    }
}
