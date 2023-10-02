import UIKit

class Login: UIViewController {
    
    private let login: UITextField = {
        let login = UITextField()
        login.placeholder = "Nome do Usuário"
        login.borderStyle = .roundedRect
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    private let password: UITextField = {
        let password = UITextField()
        password.placeholder = "Senha"
        password.borderStyle = .roundedRect
//        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .systemOrange
        loginButton.layer.borderWidth = 2.5
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    private let cadastroButton: UIButton = {
        let cadastroButton = UIButton()
        cadastroButton.setTitle("Cadastre-se", for: .normal)
        cadastroButton.setTitleColor(.black, for: .normal)
        cadastroButton.backgroundColor = .systemOrange
        cadastroButton.layer.borderWidth = 2.5
        cadastroButton.layer.cornerRadius = 15
        cadastroButton.layer.borderColor = UIColor.black.cgColor
        cadastroButton.translatesAutoresizingMaskIntoConstraints = false
        return cadastroButton
    }()
    
    private let esqueciButton: UIButton = {
        let esqueciButton = UIButton()
        esqueciButton.setTitle("Esqueci a Senha", for: .normal)
        esqueciButton.setTitleColor(.black, for: .normal)
        esqueciButton.backgroundColor = .systemOrange
        esqueciButton.titleLabel?.numberOfLines = 1
        esqueciButton.layer.borderWidth = 2.5
        esqueciButton.layer.cornerRadius = 15
        esqueciButton.layer.borderColor = UIColor.black.cgColor
        esqueciButton.translatesAutoresizingMaskIntoConstraints = false
        return esqueciButton
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "background3")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let musicPlayer = Music()
    var clickpass = "clickpass"
    var soundError = "error"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicPlayer.playBackgroundMusic()
        configConstrains()
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        cadastroButton.addTarget(self, action: #selector(cadastroButtonPressed), for: .touchUpInside)
        esqueciButton.addTarget(self, action: #selector(recoveryPassword), for: .touchUpInside)
    }
    
    @objc func recoveryPassword() {
        musicPlayer.playActionSound(soundFileName: clickpass)
        let passRecovery = LostPassword()
        navigationController?.pushViewController(passRecovery, animated: true)
    }
    
    @objc func cadastroButtonPressed() {
        musicPlayer.playActionSound(soundFileName: clickpass)
        let passNewAcc = CreateAccount()
        navigationController?.pushViewController(passNewAcc, animated: true)
    }
    
    @objc func loginButtonPressed() {
        checkText()
        guard let enteredLogin = login.text, let enteredPassword = password.text else { return }
        
        if let storedUser = SaveAccount.shared.getUser(login: enteredLogin), enteredPassword == storedUser.password {
            musicPlayer.playActionSound(soundFileName: clickpass)
            SessionManager.shared.loginUser(withLogin: enteredLogin)
            let createViewController = CreateCharacter()
            navigationController?.pushViewController(createViewController, animated: true)
            login.text = ""
            password.text = ""
        } else {
            musicPlayer.playActionSound(soundFileName: soundError)
            let alertController = UIAlertController(title: "Erro", message: "Login ou senha incorretos.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func alert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func checkText() {
        if login.text?.isEmpty == true || password.text?.isEmpty == true {
            musicPlayer.playActionSound(soundFileName: soundError)
            alert(title: "Preencha todos dados solicitados")
        }
        else {
            print("Dados preenchidos")
        }
    }
    
    func configConstrains() {
        view.addSubview(imageView)
        view.addSubview(login)
        view.addSubview(password)
        view.addSubview(loginButton)
        view.addSubview(cadastroButton)
        view.addSubview(esqueciButton)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            login.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            cadastroButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            cadastroButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cadastroButton.widthAnchor.constraint(equalToConstant: 200),
            cadastroButton.heightAnchor.constraint(equalToConstant: 40),
            
            esqueciButton.topAnchor.constraint(equalTo: cadastroButton.bottomAnchor, constant: 10),
            esqueciButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            esqueciButton.widthAnchor.constraint(equalToConstant: 200),
            esqueciButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
