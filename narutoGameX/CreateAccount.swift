import UIKit

class CreateAccount: UIViewController {
    
    private let createLogin: UITextField = {
        let createLogin = UITextField()
        createLogin.placeholder = "Nome do Usuário"
        createLogin.borderStyle = .roundedRect
        createLogin.translatesAutoresizingMaskIntoConstraints = false
        return createLogin
    }()
    
    private let createEmail: UITextField = {
        let createEmail = UITextField()
        createEmail.placeholder = "E-mail"
        createEmail.borderStyle = .roundedRect
        createEmail.translatesAutoresizingMaskIntoConstraints = false
        return createEmail
    }()
    
    private let createPassword: UITextField = {
        let createPassword = UITextField()
        createPassword.placeholder = "Senha"
        createPassword.borderStyle = .roundedRect
//        createPassword.isSecureTextEntry = true
        createPassword.translatesAutoresizingMaskIntoConstraints = false
        return createPassword
    }()
    
    private let repeatPassword: UITextField = {
        let repeatPassword = UITextField()
        repeatPassword.placeholder = "Repita a Senha"
        repeatPassword.borderStyle = .roundedRect
//        repeatPassword.isSecureTextEntry = true
        repeatPassword.translatesAutoresizingMaskIntoConstraints = false
        return repeatPassword
    }()
    
    private let enterButton: UIButton = {
        let enterButton = UIButton()
        enterButton.setTitle("Criar Conta", for: .normal)
        enterButton.setTitleColor(.black, for: .normal)
        enterButton.backgroundColor = .systemOrange
        enterButton.layer.borderWidth = 2.5
        enterButton.layer.cornerRadius = 15
        enterButton.layer.borderColor = UIColor.black.cgColor
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        return enterButton
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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background2")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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
                showSuccessAndNavigate()
            } else {
                self.alert(title: "Use um e-mail válido, no mínimo 6 caracteres em sua senha e a confirme corretamente!")
            }
        }
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
        if createLogin.text?.isEmpty == true || createEmail.text?.isEmpty == true || createPassword.text?.isEmpty == true || repeatPassword.text?.isEmpty == true {
            alert(title: "Preencha todos dados solicitados")
        }
        else {
            print("xd")
        }
    }
    
    func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(createLogin)
        view.addSubview(createEmail)
        view.addSubview(createPassword)
        view.addSubview(repeatPassword)
        view.addSubview(enterButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            createLogin.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            createLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createEmail.topAnchor.constraint(equalTo: createLogin.bottomAnchor, constant: 20),
            createEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createPassword.topAnchor.constraint(equalTo: createEmail.bottomAnchor, constant: 20),
            createPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            repeatPassword.topAnchor.constraint(equalTo: createPassword.bottomAnchor, constant: 20),
            repeatPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            enterButton.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 20),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.widthAnchor.constraint(equalToConstant: 200),
            enterButton.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
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
