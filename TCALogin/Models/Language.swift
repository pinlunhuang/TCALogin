import Foundation

enum Language: String, Equatable, CaseIterable {
    case english = "en"
    case traditionalChinese = "zh-Hant"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .traditionalChinese: return "Traditional Chinese"
        }
    }

    var flag: String {
        switch self {
        case .english: return "🇺🇸"
        case .traditionalChinese: return "🇹🇼"
        }
    }
}
