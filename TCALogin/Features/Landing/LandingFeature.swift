import ComposableArchitecture

struct LandingFeature: Reducer {
    struct State: Equatable {
        var loginState = LoginFeature.State()
        var showLanguageSelector = false
        var showEmailVerify = false
        var showOnboarding = false
        var currentLanguage: Language = .english
    }

    enum Action {
        case login(LoginFeature.Action)
        case languageSelected(Language)
        case dismissLanguageSelector
        case dismissEmailVerify
        case dismissOnboarding
    }

    @Dependency(\.userDefaultsService) var userDefaultsService

    var body: some ReducerOf<Self> {
        Scope(state: \.loginState, action: /Action.login) {
            LoginFeature()
        }

        Reduce { state, action in
            switch action {
            case .login(.loginSuccess):
                state.showOnboarding = true
                return .none

            case .login(.signUpSuccess):
                state.showEmailVerify = true
                return .none

            case let .languageSelected(language):
                state.currentLanguage = language
                return .run { _ in
                    await userDefaultsService.setLanguage(language)
                }

            case .dismissLanguageSelector:
                state.showLanguageSelector = false
                return .none

            case .dismissEmailVerify:
                state.showEmailVerify = false
                return .none

            case .dismissOnboarding:
                state.showOnboarding = false
                return .none

            default:
                return .none
            }
        }
    }
}
