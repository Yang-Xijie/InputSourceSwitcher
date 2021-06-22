//
//  InputSource.swift
//  InputSourceSwitcher
//
//  Created by 杨希杰 on 2021/6/22.
//

import Foundation

struct InputSource: Identifiable {
    var name: String = ""
    var id: Int = 0
}

extension InputSource: CustomStringConvertible {
    var description: String {
        return name
    }
}
