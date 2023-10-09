import UIKit

class MyAccount: UIViewController {

    var tableView: UITableView!
    var characters = [Character]()
    var selectedCharacterIndex: Int?
    var clickpass = "clickpass"
    var soundError = "error"
    let musicPlayer = Music()
    
    private let imageView = ImageDefault(imageName: "background6")
    
    private let enterGame = ButtonDefault(title: "Entrar no Jogo")
    private let createCharacterView = ButtonDefault(title: "Criar Personagem")
    private let backButton = ButtonDefault(title: "Voltar")
    @objc private let deleteCharacter = ButtonDefault(title: "Deletar Personagem")
    
    struct Cells {
        static let narutoCell = "NarutoCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)

        configureTableView()
        checkAccounts()
        setElements()
    }
    
    func checkAccounts() {
        guard let loggedInUserLogin = SessionManager.shared.getLoggedInUserLogin() else { return }
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
    
    private func setElements() {
        setImageView()
        setEnterGame()
        setCreateCharacter()
        setDeleteCharacter()
        setBackButton()
    }
    
    private func setImageView() {
        view.addSubview(imageView)
        tableView.backgroundView = imageView

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setEnterGame() {
        view.addSubview(enterGame)
        
        enterGame.addTarget(self, action: #selector(enter), for: .touchUpInside)

        NSLayoutConstraint.activate([
            enterGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterGame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            enterGame.widthAnchor.constraint(equalToConstant: 200),
            enterGame.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setCreateCharacter() {
        view.addSubview(createCharacterView)

        createCharacterView.addTarget(self, action: #selector(create), for: .touchUpInside)

        NSLayoutConstraint.activate([
            createCharacterView.topAnchor.constraint(equalTo: enterGame.bottomAnchor, constant: 10),
            createCharacterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCharacterView.widthAnchor.constraint(equalToConstant: 200),
            createCharacterView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setDeleteCharacter() {
        view.addSubview(deleteCharacter)
        
        deleteCharacter.addTarget(self, action: #selector(earesedCharacter), for: .touchUpInside)

        NSLayoutConstraint.activate([
            deleteCharacter.topAnchor.constraint(equalTo: createCharacterView.bottomAnchor, constant: 10),
            deleteCharacter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteCharacter.widthAnchor.constraint(equalToConstant: 200),
            deleteCharacter.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setBackButton() {
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: deleteCharacter.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
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
