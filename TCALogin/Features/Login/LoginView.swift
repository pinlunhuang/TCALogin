import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    let store: StoreOf<LoginFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                Image("draco_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)

                Image("draco_name")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)

                HStack(spacing: 8) {
                    Button(action: {
                        if viewStore.isSignUpMode {
                            viewStore.send(.toggleMode)
                        }
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(viewStore.isSignUpMode ? Color.gray.opacity(0.3) : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        if !viewStore.isSignUpMode {
                            viewStore.send(.toggleMode)
                        }
                    }) {
                        Text("Sign up")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(!viewStore.isSignUpMode ? Color.gray.opacity(0.3) : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                    }) {
                        HStack {
                            Text("🇺🇸")
                            Text("EN").font(.system(size: 14))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                VStack(spacing: 16) {
                    TextField("Email", text: viewStore.binding(
                        get: \.email,
                        send: LoginFeature.Action.emailChanged
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                    SecureField("Password", text: viewStore.binding(
                        get: \.password,
                        send: LoginFeature.Action.passwordChanged
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    if viewStore.isSignUpMode {
                        SecureField("Confirm Password", text: viewStore.binding(
                            get: \.confirmPassword,
                            send: LoginFeature.Action.confirmPasswordChanged
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        VStack(alignment: .leading, spacing: 8) {
                            Text("We use SMA(Separately Managed Account) to manage the portfolio. Please select if you already have an account at Interactive Brokers.")
                                .font(.caption)
                                .foregroundColor(.gray)

                            HStack {
                                Button(action: {
                                    viewStore.send(.toggleIBKRAccount(true))
                                }) {
                                    HStack {
                                        Image(systemName: viewStore.hasIBKRAccount ? "largecircle.fill.circle" : "circle")
                                        Text("Yes, I had an IBKR account.")
                                    }
                                }
                                Spacer()
                            }

                            HStack {
                                Button(action: {
                                    viewStore.send(.toggleIBKRAccount(false))
                                }) {
                                    HStack {
                                        Image(systemName: !viewStore.hasIBKRAccount ? "largecircle.fill.circle" : "circle")
                                        Text("No, I don't have an IBKR account.")
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal)

                Button(action: {
                    if viewStore.isSignUpMode {
                        viewStore.send(.signUpTapped)
                    } else {
                        viewStore.send(.loginTapped)
                    }
                }) {
                    if viewStore.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text(viewStore.isSignUpMode ? "Sign up" : "Login")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 50)
        }
    }
}
