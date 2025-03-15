import ComposableArchitecture
import SwiftUI

struct LanguageButton: View {
    let flag: String
    let language: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(flag)
                Text(language)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
        }
    }
}

struct LanguageSelectorView: View {
    let store: StoreOf<LandingFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                headerView(viewStore)

                languageOptionsView(viewStore)

                Spacer()

                saveButton(viewStore)
            }
        }
    }

    // MARK: - Component Views
    private func headerView(_ viewStore: ViewStore<LandingFeature.State, LandingFeature.Action>) -> some View {
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
    }

    private func languageOptionsView(_ viewStore: ViewStore<LandingFeature.State, LandingFeature.Action>) -> some View {
        VStack(spacing: 16) {
            LanguageButton(
                flag: "🇺🇸",
                language: "English",
                isSelected: viewStore.currentLanguage == .english,
                action: { viewStore.send(.languageSelected(.english)) }
            )

            LanguageButton(
                flag: "🇹🇼",
                language: "Traditional Chinese",
                isSelected: viewStore.currentLanguage == .traditionalChinese,
                action: { viewStore.send(.languageSelected(.traditionalChinese)) }
            )
        }
        .padding()
    }

    private func saveButton(_ viewStore: ViewStore<LandingFeature.State, LandingFeature.Action>) -> some View {
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
