//
//  InputSources.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import Foundation
struct InputSources {
    var currentInputSources: [InputSource] = []

    init() {
        currentInputSources = GetCurrentInputSourcesInMenubar()
    }

    mutating func Reset() {
        currentInputSources = GetCurrentInputSourcesInMenubar()
    }

    mutating func InsertInputSource(name: String, id: Int) {
        currentInputSources.append(InputSource(name: name, id: id))
    }
}
