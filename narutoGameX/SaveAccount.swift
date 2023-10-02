import UIKit

class SaveAccount {
    
    static let shared = SaveAccount()
    private let userDefaults = UserDefaults.standard
    private let userKey = "users"
    
    private func getUsers() -> [User] {
        if let usersData = userDefaults.data(forKey: userKey) {
            if let users = try? JSONDecoder().decode([User].self, from: usersData) {
                return users
            }
        }
        return []
    }
    
    private func saveUsers(_ users: [User]) {
        if let usersData = try? JSONEncoder().encode(users) {
            userDefaults.set(usersData, forKey: userKey)
        }
    }
    
    func saveUser(_ user: User) {
        var users = getUsers()
        
        let userExists = users.contains { existingUser in
            return existingUser.login == user.login
        }
        
        if userExists {
            let alertController = UIAlertController(title: "Aviso", message: "O nome de usuário já está em uso.", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertButton)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        } else {
            users.append(user)
            saveUsers(users)
        }
    }
    
    func updateUserPassword(login: String, newPassword: String) {
        let users = getUsers()
        
        guard let existingUserIndex = users.firstIndex(where: { user in
            return user.login == login
        }) else {
            let alertController = UIAlertController(title: "Aviso", message: "O usuário não existe.", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertButton)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            return
        }
        
        users[existingUserIndex].password = newPassword
        saveUsers(users)
    }
    
    func getUser(login: String) -> User? {
        let users = getUsers()
        return users.first { user in
            return user.login == login
        }
    }
    
    func isLoginInUse(login: String) -> Bool {
        let users = getUsers()
        return users.contains { user in
            return user.login == login
        }
    }
    
    func saveCharacterForUser(login: String, character: Character) {
        let users = getUsers()
        
        guard let userIndex = users.firstIndex(where: { user in
            return user.login == login
        }) else {
            return
        }
        users[userIndex].characters.append(character)
        
        saveUsers(users)
    }
    
    func getCharactersForUser(login: String) -> [Character]? {
        let users = getUsers()
        
        guard let user = users.first(where: { user in
            return user.login == login
        }) else {
            return nil
        }
        return user.characters
    }
    
    func removeCharacterForUser(login: String, character: Character) {
        let users = getUsers()
        
        guard let userIndex = users.firstIndex(where: { user in
            return user.login == login
        }) else {
            return
        }
        if let characterIndex = users[userIndex].characters.firstIndex(where: { $0.name == character.name }) {
            users[userIndex].characters.remove(at: characterIndex)
        }
        saveUsers(users)
    }
}
