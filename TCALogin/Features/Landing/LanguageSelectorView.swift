import ComposableArchitecture
import SwiftUI

struct LanguageSelectorView: View {
    let store: StoreOf<LandingFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Button(action: {
                        viewStore.send(.dismissLanguageSelector)
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()

                VStack(spacing: 16) {
                    Button(action: {
                        viewStore.send(.languageSelected(.english))
                    }) {
                        HStack {
                            Text("🇺🇸")
                            Text("English")
                            Spacer()
                            if viewStore.currentLanguage == .english {
                                Image(systemName: "checkmark")
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                    }

                    Button(action: {
                        viewStore.send(.languageSelected(.chinese))
                    }) {
                        HStack {
                            Text("🇹🇼")
                            Text("Traditional Chinese")
                            Spacer()
                            if viewStore.currentLanguage == .chinese {
                                Image(systemName: "checkmark")
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                    }
                }
                .padding()

                Spacer()

                Button(action: {
                    viewStore.send(.dismissLanguageSelector)
                }) {
                    Text("Save & Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}
