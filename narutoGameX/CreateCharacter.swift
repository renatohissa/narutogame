import UIKit

class CreateCharacter: UIViewController {

    var clickpass = "clickpass"
    var soundError = "error"
    private let musicPlayer = Music()
    private var animationTimer: Timer?
    private var currentOpacity: CGFloat = 0.5
    private let opacityChangeAmount: CGFloat = 0.1
    private var increasingOpacity = true
    var sasukeImagePressed = false
    var characterImageIdentifier = false

    private let screenImageView = ImageDefault(imageName: "background5")
    private let narutoCharacterImage = ImageDefault(imageName: "narutoselected01", userInteraction: true)
    private let sasukeCharacterImage = ImageDefault(imageName: "sasukeselected01", userInteraction: true)
    private let narutoStaticImage = ImageDefault(imageName: "narutomove01", userInteraction: true)
    private let sasukeStaticImage = ImageDefault(imageName: "sasukemove01", userInteraction: true)
    
    private let textNickName1 = TextFieldDefault(placeholder: "Digite seu Nick", isSecure: false)
    
    private let createCharacter = ButtonDefault(title: "Criar Personagem")
    private let charactersScreen = ButtonDefault(title: "Meus Personagens")
    private let backButton = ButtonDefault(title: "Voltar")
    
    private let narutoRunImage = ImageDefault(imageName: "narurun0", userInterection: true, countImagens: 8)
    private let sasukeMoveImage = ImageDefault(imageName: "sasurun0", userInterection: true, countImagens: 8)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)

        setElements()
    }
    
    private func setElements() {
        setScreenImage()
        setNarutoCharacterImage()
        setNarutoRunImage()
        setNarutoStaticImage()
        setSasukeCharacterImage()
        setSasukeStaticImage()
        setSasukeMoveImage()
        setTextNickName()
        setCreateCharacter()
        setCharactersScreen()
        setBackButton()
    }
    
    private func setScreenImage() {
        view.addSubview(screenImageView)

        NSLayoutConstraint.activate([
            screenImageView.topAnchor.constraint(equalTo: view.topAnchor),
            screenImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screenImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setNarutoCharacterImage() {
        view.addSubview(narutoCharacterImage)
        
        let narutoTapGesture = UITapGestureRecognizer(target: self, action: #selector(narutoImageTapped))
        narutoCharacterImage.addGestureRecognizer(narutoTapGesture)

        NSLayoutConstraint.activate([
            narutoCharacterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            narutoCharacterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            narutoCharacterImage.widthAnchor.constraint(equalToConstant: 150),
            narutoCharacterImage.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    private func setNarutoRunImage() {
        view.addSubview(narutoRunImage)
        
        NSLayoutConstraint.activate([
            narutoRunImage.topAnchor.constraint(equalTo: narutoCharacterImage.bottomAnchor, constant: 10),
            narutoRunImage.centerXAnchor.constraint(equalTo: narutoCharacterImage.centerXAnchor), //
            narutoRunImage.widthAnchor.constraint(equalToConstant: 60),
            narutoRunImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setNarutoStaticImage() {
        narutoRunImage.alpha = 0.0
        view.addSubview(narutoStaticImage)
        
        NSLayoutConstraint.activate([
            narutoStaticImage.topAnchor.constraint(equalTo: narutoCharacterImage.bottomAnchor, constant: 10),
            narutoStaticImage.centerXAnchor.constraint(equalTo: narutoCharacterImage.centerXAnchor), //
            narutoStaticImage.widthAnchor.constraint(equalToConstant: 60),
            narutoStaticImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setSasukeCharacterImage() {
        view.addSubview(sasukeCharacterImage)
        
        let sasukeTapGesture = UITapGestureRecognizer(target: self, action: #selector(sasukeImageTapped))
        sasukeCharacterImage.addGestureRecognizer(sasukeTapGesture)

        NSLayoutConstraint.activate([
            sasukeCharacterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            sasukeCharacterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sasukeCharacterImage.widthAnchor.constraint(equalToConstant: 150),
            sasukeCharacterImage.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    private func setSasukeStaticImage() {
        sasukeMoveImage.alpha = 0.0
        
        view.addSubview(sasukeStaticImage)

        NSLayoutConstraint.activate([
            sasukeStaticImage.topAnchor.constraint(equalTo: sasukeCharacterImage.bottomAnchor, constant: 10),
            sasukeStaticImage.centerXAnchor.constraint(equalTo: sasukeCharacterImage.centerXAnchor),
            sasukeStaticImage.widthAnchor.constraint(equalToConstant: 60),
            sasukeStaticImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setSasukeMoveImage() {
        view.addSubview(sasukeMoveImage)

        NSLayoutConstraint.activate([
            sasukeMoveImage.topAnchor.constraint(equalTo: sasukeCharacterImage.bottomAnchor, constant: 10),
            sasukeMoveImage.centerXAnchor.constraint(equalTo: sasukeCharacterImage.centerXAnchor),
            sasukeMoveImage.widthAnchor.constraint(equalToConstant: 60),
            sasukeMoveImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setTextNickName() {
        view.addSubview(textNickName1)

        NSLayoutConstraint.activate([
            textNickName1.topAnchor.constraint(equalTo: sasukeStaticImage.bottomAnchor, constant: 10),
            textNickName1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textNickName1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setCreateCharacter() {
        view.addSubview(createCharacter)

        createCharacter.addTarget(self, action: #selector(createCharacterPress), for: .touchUpInside)

        NSLayoutConstraint.activate([
            createCharacter.topAnchor.constraint(equalTo: textNickName1.bottomAnchor, constant: 10),
            createCharacter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCharacter.widthAnchor.constraint(equalToConstant: 200),
            createCharacter.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setCharactersScreen() {
        view.addSubview(charactersScreen)

        charactersScreen.addTarget(self, action: #selector(telaDePersonagens), for: .touchUpInside)

        NSLayoutConstraint.activate([
            charactersScreen.topAnchor.constraint(equalTo: createCharacter.bottomAnchor, constant: 10),
            charactersScreen.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charactersScreen.widthAnchor.constraint(equalToConstant: 200),
            charactersScreen.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setBackButton() {
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(goBackButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: charactersScreen.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func getImage() -> UIImage? {
        if sasukeImagePressed == true {
            return UIImage(named: "sasukeicon1")
        } else {
            return UIImage(named: "narutoicon1")
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Erro", message: "Selecione um personagem para jogar e/ou preencha o nickname.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func goToHome() {
        let passVC = MyAccount()
        navigationController?.pushViewController(passVC, animated: true)
    }
    
    @objc func telaDePersonagens() {
        musicPlayer.playActionSound(soundFileName: clickpass)
        let tela = MyAccount()
        navigationController?.pushViewController(tela, animated: true)
        textNickName1.text = ""
    }
    
    @objc func createCharacterPress() {
        guard let characterName = textNickName1.text else { return }
        guard let characterImage = getImage() else {
            return
        }
        
        if characterImageIdentifier && !textNickName1.text!.isEmpty {
    
            if let loggedInUserLogin = SessionManager.shared.getLoggedInUserLogin() {
                let character = Character(name: characterName, image: characterImage)
                SaveAccount.shared.saveCharacterForUser(login: loggedInUserLogin, character: character)
                musicPlayer.playActionSound(soundFileName: clickpass)
                let alertController = UIAlertController(title: "Sucesso", message: "Personagem criado com sucesso!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    self.goToHome()
                })
                self.present(alertController, animated: true, completion: nil)
                textNickName1.text = ""
            }
        } else {
            musicPlayer.playActionSound(soundFileName: soundError)
            showError()
        }
    }
    
    @objc func goBackButton() {
        SessionManager.shared.logoutUser()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sasukeImageTapped() {
        sasukeImagePressed = true
        characterImageIdentifier = true
        sasukeStaticImage.alpha = 0.0
        narutoRunImage.alpha = 0.0
        narutoStaticImage.alpha = 1.0
        sasukeMoveImage.alpha = 1.0
        
        if animationTimer == nil {
            animationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(sasukeUpdateOpacity), userInfo: nil, repeats: true)
            musicPlayer.playActionSound(soundFileName: "sasukeselected")
        } else {
            characterImageIdentifier = false
            sasukeImagePressed = false
            narutoCharacterImage.stopAnimating()
            narutoCharacterImage.alpha = 1.0
            sasukeCharacterImage.alpha = 1.0
            sasukeMoveImage.alpha = 0.0
            sasukeStaticImage.alpha = 1.0
            animationTimer?.invalidate()
            animationTimer = nil
        }
    }
    
    @objc func narutoImageTapped() {
        characterImageIdentifier = true
        narutoStaticImage.alpha = 0.0
        narutoRunImage.alpha = 1.0
        sasukeMoveImage.alpha = 0.0
        sasukeStaticImage.alpha = 1.0
        
        if animationTimer == nil {
            animationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(narutoUpdateOpacity), userInfo: nil, repeats: true)
            musicPlayer.playActionSound(soundFileName: "narutoselected")
        } else {
            characterImageIdentifier = false
            sasukeCharacterImage.stopAnimating()
            sasukeCharacterImage.alpha = 1.0
            narutoCharacterImage.alpha = 1.0
            narutoRunImage.alpha = 0.0
            narutoStaticImage.alpha = 1.0
            animationTimer?.invalidate()
            animationTimer = nil
        }
    }
    
    @objc func narutoUpdateOpacity() {
        if increasingOpacity {
            currentOpacity += opacityChangeAmount
            
            if currentOpacity >= 1.0 {
                increasingOpacity = false
            }
        } else {
            currentOpacity -= opacityChangeAmount
            if currentOpacity <= 0.5 {
                increasingOpacity = true
            }
        }
        narutoCharacterImage.alpha = currentOpacity
    }
    
    @objc func sasukeUpdateOpacity() {
        if increasingOpacity {
            currentOpacity += opacityChangeAmount
            
            if currentOpacity >= 1.0 {
                increasingOpacity = false
            }
        } else {
            currentOpacity -= opacityChangeAmount
            if currentOpacity <= 0.5 {
                increasingOpacity = true
            }
        }
        sasukeCharacterImage.alpha = currentOpacity
    }
}
