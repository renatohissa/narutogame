import Foundation

class SessionManager {
    static let shared = SessionManager()

    private var loggedInUserLogin: String?

    func loginUser(withLogin login: String) {
        loggedInUserLogin = login
    }

    func logoutUser() {
        loggedInUserLogin = nil
    }

    func getLoggedInUserLogin() -> String? {
        return loggedInUserLogin
    }
}
