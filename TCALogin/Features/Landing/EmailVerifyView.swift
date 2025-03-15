import ComposableArchitecture
import SwiftUI

struct EmailVerifyView: View {
    let store: StoreOf<LandingFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                Text("Verify")
                    .font(.title)
                    .bold()

                Image(systemName: "envelope")
                    .font(.system(size: 50))
                    .foregroundColor(.green)

                Text("Need Verify")
                    .font(.headline)

                Text("Your allocation will not take effect until the start of the next trading period.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                Button(action: {
                    viewStore.send(.dismissEmailVerify)
                }) {
                    Text("OK")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.black)
            .cornerRadius(16)
            .padding()
        }
    }
}
