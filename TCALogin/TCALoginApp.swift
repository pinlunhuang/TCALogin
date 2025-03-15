import ComposableArchitecture
import SwiftUI

@main
struct TCALoginApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: LandingFeature.State(),
                    reducer: { LandingFeature() }
                )
            )
        }
    }
}
