import UIKit
import Foundation

class User: Codable {
    var login: String
    var password: String
    var characters: [Character]

    init(login: String, password: String) {
        self.login = login
        self.password = password
        self.characters = []
    }
}
