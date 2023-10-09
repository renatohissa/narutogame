import UIKit

class CreateAccount: UIViewController {
    
    let musicPlayer = Music()
    var clickpass = "clickpass"
    var soundError = "error"
    
    private let createLogin = TextFieldDefault(placeholder: "Nome do Usuário", isSecure: false)
    private let createEmail = TextFieldDefault(placeholder: "E-mail", keyboardType: .emailAddress)
    private let createPassword = TextFieldDefault(placeholder: "Senha", isSecure: false)
    private let repeatPassword = TextFieldDefault(placeholder: "Repita a Senha", isSecure: false)
    
    private let imageView = ImageDefault(imageName: "background2")
    
    private let enterButton = ButtonDefault(title: "Criar Conta")
    private let backButton = ButtonDefault(title: "Voltar")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        setElements()
    }
    
    private func setElements() {
        setImage()
        setCreateLogin()
        setCreateEmail()
        setCreatePassword()
        setRepeatPassword()
        setEnterButton()
        setBackButton()
    }
    
    private func setImage() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setCreateLogin() {
        view.addSubview(createLogin)

        NSLayoutConstraint.activate([
            createLogin.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            createLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
    private func setCreateEmail() {
        view.addSubview(createEmail)

        NSLayoutConstraint.activate([
            createEmail.topAnchor.constraint(equalTo: createLogin.bottomAnchor, constant: 20),
            createEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setCreatePassword() {
        view.addSubview(createPassword)

        NSLayoutConstraint.activate([
            createPassword.topAnchor.constraint(equalTo: createEmail.bottomAnchor, constant: 20),
            createPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setRepeatPassword() {
        view.addSubview(repeatPassword)

        NSLayoutConstraint.activate([
            repeatPassword.topAnchor.constraint(equalTo: createPassword.bottomAnchor, constant: 20),
            repeatPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setEnterButton() {
        view.addSubview(enterButton)

        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)

        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 20),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.widthAnchor.constraint(equalToConstant: 200),
            enterButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setBackButton() {
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func showSuccessAndNavigate() {
        let alertController = UIAlertController(title: "Sucesso", message: "Conta criada com sucesso!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.backButtonPressed()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    func alert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func checkTextAlert() {
        musicPlayer.playActionSound(soundFileName: soundError)
        if createLogin.text?.isEmpty == true || createEmail.text?.isEmpty == true || createPassword.text?.isEmpty == true || repeatPassword.text?.isEmpty == true {
            alert(title: "Preencha todos dados solicitados")
        }
        else {
            print("xd")
        }
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func enterButtonPressed() {
        let username = createLogin.text ?? ""
        let userpassword = createPassword.text ?? ""
        let repeatpassword = repeatPassword.text ?? ""
        let useremail = createEmail.text ?? ""
        
        switch (username.isEmpty || userpassword.isEmpty || repeatpassword.isEmpty || useremail.isEmpty) {
            
        case true:
            checkTextAlert()
            
        case false:
            
            if createEmail.validateEmail() && createPassword.validatePassword() && userpassword == repeatpassword {
                guard let login = createLogin.text, let password = createPassword.text else {
                    return
                }
                let user = User(login: login, password: password)
                SaveAccount.shared.saveUser(user)
                musicPlayer.playActionSound(soundFileName: clickpass)
                showSuccessAndNavigate()
            } else {
                musicPlayer.playActionSound(soundFileName: soundError)
                self.alert(title: "Use um e-mail válido, no mínimo 6 caracteres em sua senha e a confirme corretamente!")
            }
        }
    }
}

extension UITextField {
    
    func validateEmail() -> Bool {
        let emailValidate = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let validateControl = NSPredicate(format: "SELF MATCHES %@", emailValidate)
        return validateControl.evaluate(with: self.text)
    }
    
    func validatePassword() -> Bool {
        let passwordValidate = ".{6,}"
        let validateControl = NSPredicate(format: "SELF MATCHES %@", passwordValidate)
        return validateControl.evaluate(with: self.text)
    }
}
