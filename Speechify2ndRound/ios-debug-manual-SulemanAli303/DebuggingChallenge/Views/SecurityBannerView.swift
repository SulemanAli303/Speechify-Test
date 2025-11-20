import SwiftUI

struct SecurityBannerView: View {
    @EnvironmentObject var auth: AuthenticationManager
    @State private var lastUsername: String = ""
    let sessionService: SessionService

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome to the")
                .font(.title2)
                .foregroundColor(.secondary)

            Text("Debugging Challenge")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)

            Text(auth.username.isEmpty ? "Please enter your username" : "Username: \(auth.username)")
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.95, green: 0.95, blue: 0.95),
                            Color(red: 0.98, green: 0.98, blue: 0.98)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(
                    color: Color.black.opacity(0.1),
                    radius: 10,
                    x: 0,
                    y: 4
                )
        )
        .onAppear {
            lastUsername = auth.username
        }
        .onChange(of: auth.username) { newUsername in
            lastUsername = newUsername
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
        .execute {
            sessionService.initializeVerificationProcess()
        }
    }
}
