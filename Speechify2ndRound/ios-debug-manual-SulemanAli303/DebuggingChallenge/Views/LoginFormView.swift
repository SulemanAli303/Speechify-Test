import SwiftUI

struct LoginFormView: View {
    @EnvironmentObject var auth: AuthenticationManager
    let sessionService: SessionService
    let onSuccess: () -> Void
    @State private var tempUsername: String = ""
    @State private var tempPassword: String = ""

    private var isInvalid: Bool {
        auth.username.isEmpty || tempPassword.isEmpty
    }

    var body: some View {
        VStack(spacing: 24) {
            TextField("Username", text: $tempUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 4)

            SecureField("Password", text: $tempPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 4)

            HStack(spacing: 16) {
                Button(action: {
                    auth.username = tempUsername
                }) {
                    Text("Set Username")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                /*
                 *****************************************************************************
                 *                                                                           *
                 *     >>>>>>>>>>>  DO NOT MODIFY ANYTHING FROM THIS POINT  <<<<<<<<<<<      *
                 *                                                                           *
                 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
                 *                                                                           *
                 *****************************************************************************
                 */
                Button(action: {
                    sessionService.verify {
                        switch $0 {
                        case .success:
                            onSuccess()
                        case .error:
                            print("Login failed!")
                        }
                    }

                    auth.passwordAttempts += 1
                }) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .opacity(isInvalid ? 0.2 : 1)
                .disabled(isInvalid)
            }

            Text("Login Attempts: \(auth.passwordAttempts)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(24)

    }
}
