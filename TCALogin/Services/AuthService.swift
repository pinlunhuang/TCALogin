import Foundation
import ComposableArchitecture

struct AuthService {
    var login: @Sendable (String, String) async throws -> AuthResponse
    var signUp: @Sendable (String, String) async throws -> AuthResponse
}

extension AuthService: DependencyKey {
    static let liveValue = AuthService(
        login: { email, password in
            try await Task.sleep(nanoseconds: 1_000_000_000)
            return AuthResponse(token: "token", requiresVerification: false)
        },
        signUp: { email, password in
            try await Task.sleep(nanoseconds: 1_000_000_000)
            return AuthResponse(token: "token", requiresVerification: true)
        }
    )

    static let testValue = AuthService(
        login: { _, _ in AuthResponse(token: "test-token", requiresVerification: false) },
        signUp: { _, _ in AuthResponse(token: "test-token", requiresVerification: true) }
    )
}

extension DependencyValues {
    var authService: AuthService {
        get { self[AuthService.self] }
        set { self[AuthService.self] = newValue }
    }
}
