import UIKit

class MyAccount: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background6")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let enterGame: UIButton = {
        let enterGame = UIButton()
        enterGame.setTitle("Entrar no Jogo", for: .normal)
        enterGame.setTitleColor(.black, for: .normal)
        enterGame.backgroundColor = .systemOrange
        enterGame.layer.borderColor = UIColor.black.cgColor
        enterGame.layer.borderWidth = 2.5
        enterGame.layer.cornerRadius = 15
        enterGame.translatesAutoresizingMaskIntoConstraints = false
        return enterGame
    }()
    
    private let createCharacterView: UIButton = {
        let createCharacterView = UIButton()
        createCharacterView.setTitle("Criar Personagem", for: .normal)
        createCharacterView.setTitleColor(.black, for: .normal)
        createCharacterView.backgroundColor = .systemOrange
        createCharacterView.layer.borderColor = UIColor.black.cgColor
        createCharacterView.layer.borderWidth = 2.5
        createCharacterView.layer.cornerRadius = 15
        createCharacterView.translatesAutoresizingMaskIntoConstraints = false
        return createCharacterView
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("Voltar", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.backgroundColor = .systemOrange
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.borderWidth = 2.5
        backButton.layer.cornerRadius = 15
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    @objc private let deleteCharacter: UIButton = {
        let deleteCharacter = UIButton()
        deleteCharacter.setTitle("Deletar Personagem", for: .normal)
        deleteCharacter.setTitleColor(.black, for: .normal)
        deleteCharacter.backgroundColor = .systemOrange
        deleteCharacter.layer.borderColor = UIColor.black.cgColor
        deleteCharacter.layer.borderWidth = 2.5
        deleteCharacter.layer.cornerRadius = 15
        deleteCharacter.translatesAutoresizingMaskIntoConstraints = false
        return deleteCharacter
    }()
    
    var tableView: UITableView!
    var characters = [Character]()
    var selectedCharacterIndex: Int?
    var clickpass = "clickpass"
    var soundError = "error"
    let musicPlayer = Music()
    
    struct Cells {
        static let narutoCell = "NarutoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        checkAccounts()
        checkConstraints()
        
        enterGame.addTarget(self, action: #selector(enter), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        createCharacterView.addTarget(self, action: #selector(create), for: .touchUpInside)
        deleteCharacter.addTarget(self, action: #selector(earesedCharacter), for: .touchUpInside)
    }
    
    @objc func earesedCharacter() {
        if let selectedIndex = selectedCharacterIndex {
            let character = characters[selectedIndex]
            musicPlayer.playActionSound(soundFileName: soundError)
            let alertController = UIAlertController(title: "Confirmação", message: "Tem certeza que deseja apagar '\(character.name)'?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Sim", style: .destructive) { _ in
                
                guard let loggedInUserLogin = SessionManager.shared.getLoggedInUserLogin() else {
                    
                    return
                }
                
                SaveAccount.shared.removeCharacterForUser(login: loggedInUserLogin, character: character)
                
                self.characters.remove(at: selectedIndex)
                self.tableView.reloadData()
                self.selectedCharacterIndex = nil
            })
            alertController.addAction(UIAlertAction(title: "Não", style: .cancel))
            present(alertController, animated: true)
        }
    }
    
    @objc func create() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func enter() {
        if let selectedCharacterIndex = selectedCharacterIndex {
            musicPlayer.playActionSound(soundFileName: clickpass)
            let passNewAcc = InGame()
            navigationController?.pushViewController(passNewAcc, animated: true)
        } else {
            musicPlayer.playActionSound(soundFileName: soundError)
            let alertController = UIAlertController(title: "Aviso", message: "Escolha um personagem para iniciar o jogo!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func checkAccounts() {
        guard let loggedInUserLogin = SessionManager.shared.getLoggedInUserLogin() else {
            return
        }
        if let charactersForUser = SaveAccount.shared.getCharactersForUser(login: loggedInUserLogin) {
            characters = charactersForUser
            tableView.reloadData()
        }
    }
    
    func configureTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.rowHeight = 120
        tableView.register(MyCharacters.self, forCellReuseIdentifier: Cells.narutoCell)
    }
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func checkConstraints() {
        view.addSubview(enterGame)
        view.addSubview(createCharacterView)
        view.addSubview(deleteCharacter)
        view.addSubview(backButton)
        view.addSubview(imageView)
        tableView.backgroundView = imageView
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            enterGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterGame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            enterGame.widthAnchor.constraint(equalToConstant: 200),
            enterGame.heightAnchor.constraint(equalToConstant: 40),
            
            createCharacterView.topAnchor.constraint(equalTo: enterGame.bottomAnchor, constant: 10),
            createCharacterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCharacterView.widthAnchor.constraint(equalToConstant: 200),
            createCharacterView.heightAnchor.constraint(equalToConstant: 40),
            
            deleteCharacter.topAnchor.constraint(equalTo: createCharacterView.bottomAnchor, constant: 10),
            deleteCharacter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteCharacter.widthAnchor.constraint(equalToConstant: 200),
            deleteCharacter.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: deleteCharacter.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension MyAccount: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacterIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NarutoCell", for: indexPath)
        let character = characters[indexPath.row]
        cell.textLabel?.text = character.name
        
        if let characterImage = character.getImage() {
            cell.imageView?.image = characterImage
        } else {
            
            cell.imageView?.image = UIImage(named: "fallbackImage")
        }
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        return cell
    }
}
