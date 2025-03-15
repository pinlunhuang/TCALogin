import ComposableArchitecture
import SwiftUI

struct OnboardingView: View {
    let store: StoreOf<LandingFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                HStack {
                    Text("Invest")
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: {
                        viewStore.send(.dismissOnboarding)
                    }) {
                        Image(systemName: "xmark")
                    }
                }

                VStack(spacing: 30) {
                    Image("investment_icon") // Add your flower-like icon asset
                        .resizable()
                        .frame(width: 100, height: 100)

                    Text("Invest Now!")
                        .font(.title2)
                        .bold()

                    Text("Your allocation will not take effect until the start of the next trading period.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)

                    Button(action: {
                        // AI Invest action
                    }) {
                        Text("AI Invest")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.green, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        // Customize action
                    }) {
                        Text("Customize")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color.black)
            .cornerRadius(16)
            .padding()
        }
    }
}

