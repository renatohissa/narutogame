import UIKit

class SaveCharacter {
    
    static let shared = SaveCharacter()
    private let userDefaults = UserDefaults.standard
    private let charactersKey = "characters"
    
    func saveCharacter(character: Character) {
        var characters = getCharacters()
        characters.append(character)
        saveCharacters(characters)
    }
    
    func getCharacters() -> [Character] {
        if let charactersData = userDefaults.data(forKey: charactersKey) {
            if let characters = try? JSONDecoder().decode([Character].self, from: charactersData) {
                return characters
            }
        }
        return []
    }
    
    private func saveCharacters(_ characters: [Character]) {
        if let charactersData = try? JSONEncoder().encode(characters) {
            userDefaults.set(charactersData, forKey: charactersKey)
        }
    }
    
    func getAllCharacters() -> [Character] {
        return getCharacters()
    }
}
