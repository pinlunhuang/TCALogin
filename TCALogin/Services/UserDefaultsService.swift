import Foundation
import ComposableArchitecture

struct UserDefaultsService {
    var getLanguage: () -> Language
    var setLanguage: (Language) async -> Void
}

extension UserDefaultsService: DependencyKey {
    static let liveValue = UserDefaultsService(
        getLanguage: {
            let rawValue = UserDefaults.standard.string(forKey: "app_language") ?? Language.english.rawValue
            return Language(rawValue: rawValue) ?? .english
        },
        setLanguage: { language in
            UserDefaults.standard.set(language.rawValue, forKey: "app_language")
        }
    )
}

extension DependencyValues {
    var userDefaultsService: UserDefaultsService {
        get { self[UserDefaultsService.self] }
        set { self[UserDefaultsService.self] = newValue }
    }
}
