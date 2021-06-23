import Foundation

struct InputSources {
    var inputSources: [InputSource] = []

    // MARK: - init

    init() {
        inputSources = UseApplescriptToGetSystemInputSourcesInMenubar()
    }

    // MARK: - functions

    /// Update currentInputSources in model.
    mutating func GetNewInputSourcesFromSystem() {
        inputSources = UseApplescriptToGetSystemInputSourcesInMenubar()
    }

    mutating func InsertInputSource(name: String, id: Int) {
        inputSources.append(InputSource(name: name, id: id))
    }

    func SwitchInputSource(to inputSourceName: String) {
        UseApplescriptToSwitchInputSource(to: inputSourceName)
    }
}
