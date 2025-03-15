import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<LandingFeature>

    var body: some View {
        LandingView(store: store)
            .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: LandingFeature.State(),
            reducer: { LandingFeature() }
        )
    )
}
