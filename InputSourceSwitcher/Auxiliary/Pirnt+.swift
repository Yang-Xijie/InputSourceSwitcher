import Foundation

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    let time: String = "[\(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium))] "

    var output = items.map { "\($0)" }.joined(separator: separator)
    output = time + output

    Swift.print(output, terminator: terminator)
}
