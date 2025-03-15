import SwiftUI

struct AuthResponse: Equatable {
    let token: String
    let requiresVerification: Bool
}
