import Foundation

func Time() -> String {
    return "[\(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium))] "
}
