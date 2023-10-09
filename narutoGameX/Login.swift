import UIKit

class Login: UIViewController {

    let musicPlayer = Music()
    var clickpass = "clickpass"
    var soundError = "error"

    private let imageView = ImageDefault(imageName: "background3")

    private let login = TextFieldDefault(placeholder: "Nome do usuário", isSecure: false)
    private let password = TextFieldDefault(placeholder: "Senha", isSecure: true)
    
    private let loginButton = ButtonDefault(title: "Login")
    private let registerButton = ButtonDefault(title: "Cadastre-se")
    private let forgotButton = ButtonDefault(title: "Esqueci a Senha")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicPlayer.playBackgroundMusic()
        setElements()
    }
    
    private func setElements() {
        setImageView()
        setLogin()
        setPassword()
        setLoginButton()
        setRegisterButton()
        setForgotButton()
    }
    
    private func setImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setLogin() {
        view.addSubview(login)
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            login.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setPassword() {
        view.addSubview(password)

        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setLoginButton() {
        view.addSubview(loginButton)
            
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setRegisterButton() {
        view.addSubview(registerButton)

        registerButton.addTarget(self, action: #selector(cadastroButtonPressed), for: .touchUpInside)
            
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setForgotButton() {
        view.addSubview(forgotButton)

        forgotButton.addTarget(self, action: #selector(recoveryPassword), for: .touchUpInside)

        NSLayoutConstraint.activate([
            forgotButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            forgotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotButton.widthAnchor.constraint(equalToConstant: 200),
            forgotButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
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
}
