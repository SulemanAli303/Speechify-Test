import SwiftUI
/**
 # Task #3

 ## Task
 Your goal is to pass the login screen by locating and fixing a single bug.

 ## Success Criteria
 Once the issue is resolved, tapping **Login** should transition you to the second part of the challenge.

 ## Important Notes
 - Only one bug needs to be fixed to complete this task
 - Some files are marked as "DO NOT MODIFY" - these must remain unchanged
 - In certain files, only specific sections are marked as protected with clear comments
 - Modifying any protected code (either entire files or marked sections) will result in automatic task failure
 - Unmarked files and code sections may or may not contain issues requiring fixes
 - If you’re unable to fix the bug or simply prefer to move forward, you can bypass the login screen by setting `MainScreen` as the app’s root view to start directly at the second task.
 */
struct LoginScreen: View {
    @StateObject var auth = AuthenticationManager()
    let onSuccess: () -> Void

    @State var sessionService: SessionService = DefaultSessionService()

    var body: some View {
        VStack(spacing: 32) {
            SecurityBannerView(sessionService: sessionService)
            LoginFormView(sessionService: sessionService, onSuccess: onSuccess)
        }
        .padding(24)
        .frame(maxWidth: 500)
        .environmentObject(auth)
    }
}
