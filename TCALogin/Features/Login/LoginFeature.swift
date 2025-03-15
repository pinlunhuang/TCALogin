import ComposableArchitecture

struct LoginFeature: Reducer {
    struct State: Equatable {
        var email = ""
        var password = ""
        var confirmPassword = ""
        var isSignUpMode = false
        var isLoading = false
        var hasIBKRAccount = false
    }

    enum Action {
        case emailChanged(String)
        case passwordChanged(String)
        case confirmPasswordChanged(String)
        case toggleMode
        case toggleIBKRAccount(Bool)
        case loginTapped
        case signUpTapped
        case loginSuccess
        case signUpSuccess
        case loginFailure(Error)
        case signUpFailure(Error)
    }

    @Dependency(\.authService) var authService

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .emailChanged(email):
                state.email = email
                return .none

            case let .passwordChanged(password):
                state.password = password
                return .none

            case let .confirmPasswordChanged(confirmPassword):
                state.confirmPassword = confirmPassword
                return .none

            case .toggleMode:
                state.isSignUpMode.toggle()
                return .none

            case let .toggleIBKRAccount(hasAccount):
                state.hasIBKRAccount = hasAccount
                return .none

            case .loginTapped:
                state.isLoading = true
                return .run { [email = state.email, password = state.password] send in
                    do {
                        let response = try await authService.login(email, password)
                        await send(.loginSuccess)
                    } catch {
                        await send(.loginFailure(error))
                    }
                }

            case .signUpTapped:
                state.isLoading = true
                return .run { [email = state.email, password = state.password] send in
                    do {
                        let response = try await authService.signUp(email, password)
                        await send(.signUpSuccess)
                    } catch {
                        await send(.signUpFailure(error))
                    }
                }

            case .loginSuccess, .signUpSuccess:
                state.isLoading = false
                return .none

            case .loginFailure, .signUpFailure:
                state.isLoading = false
                return .none
            }
        }
    }
}
