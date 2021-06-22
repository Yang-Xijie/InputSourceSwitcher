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
