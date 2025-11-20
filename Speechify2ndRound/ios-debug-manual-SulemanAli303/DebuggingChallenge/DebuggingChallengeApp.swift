import SwiftUI

@main
struct DebuggingChallengeApp: App {
    @State private var currentScreen: CurrentScreen = .login
    var body: some Scene {
        WindowGroup {
            switch currentScreen {
            case .login:
                LoginScreen {
                    currentScreen = .main
                }
            case .main:
                MainScreen()
            }
        }
    }
}

enum CurrentScreen {
    case login, main
}
