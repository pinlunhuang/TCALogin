import ComposableArchitecture
import SwiftUI

struct LandingView: View {
    let store: StoreOf<LandingFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                LoginView(store: store.scope(
                    state: \.loginState,
                    action: LandingFeature.Action.login
                ))

                if viewStore.showLanguageSelector {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    LanguageSelectorView(store: store)
                }

                if viewStore.showEmailVerify {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    EmailVerifyView(store: store)
                }

                if viewStore.showOnboarding {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    OnboardingView(store: store)
                }
            }
        }
    }
}
