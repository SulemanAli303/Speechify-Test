import Combine

class AuthenticationManager: ObservableObject {
    @Published var username: String = ""
    @Published var passwordAttempts: Int = 0
}
