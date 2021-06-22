//
//  InputSources.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import Foundation

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
    }

    func InsertInputSourse(name: String, id: Int) {
        model.InsertInputSource(name: name, id: id)
    }
}
