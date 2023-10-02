import UIKit

class CreateCharacter: UIViewController {
    
    private let screenImageView: UIImageView = {
        let screenImageView = UIImageView()
        screenImageView.image = UIImage(named: "background5")
        screenImageView.contentMode = .scaleToFill
        screenImageView.translatesAutoresizingMaskIntoConstraints = false
        return screenImageView
    }()
    
    private let narutoCharacterImage: UIImageView = {
        let narutoCharacterImage = UIImageView()
        narutoCharacterImage.image = UIImage(named: "narutoselected01")
        narutoCharacterImage.contentMode = .scaleToFill
        narutoCharacterImage.translatesAutoresizingMaskIntoConstraints = false
        narutoCharacterImage.isUserInteractionEnabled = true
        return narutoCharacterImage
    }()
    
    private let sasukeCharacterImage: UIImageView = {
        let sasukeCharacterImage = UIImageView()
        sasukeCharacterImage.image = UIImage(named: "sasukeselected01")
        sasukeCharacterImage.contentMode = .scaleToFill
        sasukeCharacterImage.translatesAutoresizingMaskIntoConstraints = false
        sasukeCharacterImage.isUserInteractionEnabled = true
        return sasukeCharacterImage
    }()
    
    private let textNickName1: UITextField = {
        let textNickName1 = UITextField()
        textNickName1.placeholder = "Digite seu Nick"
        textNickName1.borderStyle = .roundedRect
        textNickName1.translatesAutoresizingMaskIntoConstraints = false
        return textNickName1
    }()
    
    private let createCharacter: UIButton = {
        let createCharacter = UIButton()
        createCharacter.setTitle("Criar Personagem", for: .normal)
        createCharacter.setTitleColor(.black, for: .normal)
        createCharacter.layer.borderWidth = 2.5
        createCharacter.layer.borderColor = UIColor.black.cgColor
        createCharacter.backgroundColor = .systemOrange
        createCharacter.layer.cornerRadius = 15
        createCharacter.translatesAutoresizingMaskIntoConstraints = false
        return createCharacter
    }()
    
    private let charactersScreen: UIButton = {
        let charactersScreen = UIButton()
        charactersScreen.setTitle("Meus Personagens", for: .normal)
        charactersScreen.setTitleColor(.black, for: .normal)
        charactersScreen.layer.borderWidth = 2.5
        charactersScreen.layer.borderColor = UIColor.black.cgColor
        charactersScreen.backgroundColor = .systemOrange
        charactersScreen.layer.cornerRadius = 15
        charactersScreen.translatesAutoresizingMaskIntoConstraints = false
        return charactersScreen
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("Voltar", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.backgroundColor = .systemOrange
        backButton.layer.borderWidth = 2.5
        backButton.layer.cornerRadius = 15
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private let narutoStaticImage: UIImageView = {
        let narutoStaticImage = UIImageView()
        narutoStaticImage.contentMode = .scaleToFill
        narutoStaticImage.translatesAutoresizingMaskIntoConstraints = false
        narutoStaticImage.isUserInteractionEnabled = true
        narutoStaticImage.image = UIImage(named: "narutomove01")
        return narutoStaticImage
    }()
    
    private let narutoRunImage: UIImageView = {
        let narutoRunImage = UIImageView()
        narutoRunImage.contentMode = .scaleToFill
        narutoRunImage.translatesAutoresizingMaskIntoConstraints = false
        narutoRunImage.isUserInteractionEnabled = true
        narutoRunImage.image = UIImage(named: "narurun01")
        var currentImageIndex = 0
        let narutoMoveImages: [UIImage?] = [
            UIImage(named: "narurun01"),
            UIImage(named: "narurun02"),
            UIImage(named: "narurun03"),
            UIImage(named: "narurun04"),
            UIImage(named: "narurun05"),
            UIImage(named: "narurun06"),
            UIImage(named: "narurun07"),
            UIImage(named: "narurun08")
        ]
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            currentImageIndex = (currentImageIndex + 1) % narutoMoveImages.count
            narutoRunImage.image = narutoMoveImages[currentImageIndex]
        }
        return narutoRunImage
    }()
    
    private let sasukeStaticImage: UIImageView = {
        let sasukeStaticImage = UIImageView()
        sasukeStaticImage.contentMode = .scaleToFill
        sasukeStaticImage.translatesAutoresizingMaskIntoConstraints = false
        sasukeStaticImage.isUserInteractionEnabled = true
        sasukeStaticImage.image = UIImage(named: "sasukemove01")
        return sasukeStaticImage
    }()
    
    private let sasukeMoveImage: UIImageView = {
        let sasukeMoveImage = UIImageView()
        sasukeMoveImage.contentMode = .scaleToFill
        sasukeMoveImage.translatesAutoresizingMaskIntoConstraints = false
        sasukeMoveImage.isUserInteractionEnabled = true
        sasukeMoveImage.image = UIImage(named: "sasurun01")
        var currentImageIndex = 0
        let sasukeMoveImages: [UIImage?] = [
            UIImage(named: "sasurun01"),
            UIImage(named: "sasurun02"),
            UIImage(named: "sasurun03"),
            UIImage(named: "sasurun04"),
            UIImage(named: "sasurun05"),
            UIImage(named: "sasurun06"),
            UIImage(named: "sasurun07"),
            UIImage(named: "sasurun08")
        ]
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            currentImageIndex = (currentImageIndex + 1) % sasukeMoveImages.count
            sasukeMoveImage.image = sasukeMoveImages[currentImageIndex]
        }
        return sasukeMoveImage
    }()
    
    let musicPlayer = Music()
    private var animationTimer: Timer?
    private var currentOpacity: CGFloat = 0.5
    private let opacityChangeAmount: CGFloat = 0.1
    private var increasingOpacity = true
    var sasukeImagePressed = false
    var characterImageIdentifier = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
        let narutoTapGesture = UITapGestureRecognizer(target: self, action: #selector(narutoImageTapped))
        narutoCharacterImage.addGestureRecognizer(narutoTapGesture)
        
        let sasukeTapGesture = UITapGestureRecognizer(target: self, action: #selector(sasukeImageTapped))
        sasukeCharacterImage.addGestureRecognizer(sasukeTapGesture)
        
        createCharacter.addTarget(self, action: #selector(createCharacterPress), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(goBackButton), for: .touchUpInside)
        charactersScreen.addTarget(self, action: #selector(telaDePersonagens), for: .touchUpInside)
    }
    
    @objc func telaDePersonagens() {
        let tela = MyAccount()
        navigationController?.pushViewController(tela, animated: true)
        textNickName1.text = ""
    }
    
    @objc func createCharacterPress() {
        guard let characterName = textNickName1.text else { return }
        guard let characterImage = getImage() else {
            return
        }
        
        if characterImageIdentifier {
    
            if let loggedInUserLogin = SessionManager.shared.getLoggedInUserLogin() {
                let character = Character(name: characterName, image: characterImage)
                SaveAccount.shared.saveCharacterForUser(login: loggedInUserLogin, character: character)
                
                let alertController = UIAlertController(title: "Sucesso", message: "Personagem criado com sucesso!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    self.goToHome()
                })
                self.present(alertController, animated: true, completion: nil)
                textNickName1.text = ""
            }
        } else {
            showError()
        }
    }
    
    func getImage() -> UIImage? {
        if sasukeImagePressed == true {
            return UIImage(named: "sasukeicon1")
        } else {
            return UIImage(named: "narutoicon1")
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Erro", message: "Selecione um personagem para jogar.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func goToHome() {
        let passVC = MyAccount()
        navigationController?.pushViewController(passVC, animated: true)
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
    
    func setupConstraints() {
        sasukeMoveImage.alpha = 0.0
        narutoRunImage.alpha = 0.0
        
        view.addSubview(screenImageView)
        view.addSubview(narutoCharacterImage)
        view.addSubview(sasukeCharacterImage)
        view.addSubview(textNickName1)
        view.addSubview(narutoRunImage)
        view.addSubview(narutoStaticImage)
        view.addSubview(sasukeStaticImage)
        view.addSubview(sasukeMoveImage)
        view.addSubview(createCharacter)
        view.addSubview(backButton)
        view.addSubview(charactersScreen)
        
        NSLayoutConstraint.activate([
            
            screenImageView.topAnchor.constraint(equalTo: view.topAnchor),
            screenImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screenImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            narutoCharacterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            narutoCharacterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            narutoCharacterImage.widthAnchor.constraint(equalToConstant: 150),
            narutoCharacterImage.heightAnchor.constraint(equalToConstant: 180),
            
            narutoRunImage.topAnchor.constraint(equalTo: narutoCharacterImage.bottomAnchor, constant: 10),
            narutoRunImage.centerXAnchor.constraint(equalTo: narutoCharacterImage.centerXAnchor), //
            narutoRunImage.widthAnchor.constraint(equalToConstant: 60),
            narutoRunImage.heightAnchor.constraint(equalToConstant: 70),
            
            narutoStaticImage.topAnchor.constraint(equalTo: narutoCharacterImage.bottomAnchor, constant: 10),
            narutoStaticImage.centerXAnchor.constraint(equalTo: narutoCharacterImage.centerXAnchor), //
            narutoStaticImage.widthAnchor.constraint(equalToConstant: 60),
            narutoStaticImage.heightAnchor.constraint(equalToConstant: 70),
            
            sasukeStaticImage.topAnchor.constraint(equalTo: sasukeCharacterImage.bottomAnchor, constant: 10),
            sasukeStaticImage.centerXAnchor.constraint(equalTo: sasukeCharacterImage.centerXAnchor),
            sasukeStaticImage.widthAnchor.constraint(equalToConstant: 60),
            sasukeStaticImage.heightAnchor.constraint(equalToConstant: 70),
            
            sasukeMoveImage.topAnchor.constraint(equalTo: sasukeCharacterImage.bottomAnchor, constant: 10),
            sasukeMoveImage.centerXAnchor.constraint(equalTo: sasukeCharacterImage.centerXAnchor),
            sasukeMoveImage.widthAnchor.constraint(equalToConstant: 60),
            sasukeMoveImage.heightAnchor.constraint(equalToConstant: 70),
            
            textNickName1.topAnchor.constraint(equalTo: sasukeStaticImage.bottomAnchor, constant: 10),
            textNickName1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textNickName1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sasukeCharacterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            sasukeCharacterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sasukeCharacterImage.widthAnchor.constraint(equalToConstant: 150),
            sasukeCharacterImage.heightAnchor.constraint(equalToConstant: 180),
            
            createCharacter.topAnchor.constraint(equalTo: textNickName1.bottomAnchor, constant: 10),
            createCharacter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCharacter.widthAnchor.constraint(equalToConstant: 200),
            createCharacter.heightAnchor.constraint(equalToConstant: 40),
            
            charactersScreen.topAnchor.constraint(equalTo: createCharacter.bottomAnchor, constant: 10),
            charactersScreen.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charactersScreen.widthAnchor.constraint(equalToConstant: 200),
            charactersScreen.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: charactersScreen.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
