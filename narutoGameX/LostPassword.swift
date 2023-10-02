import UIKit

class LostPassword: UIViewController {
    
    private let screenImageView: UIImageView = {
        let screenImageView = UIImageView()
        screenImageView.image = UIImage(named: "background8")
        screenImageView.contentMode = .scaleToFill
        screenImageView.translatesAutoresizingMaskIntoConstraints = false
        return screenImageView
    }()
    
    private let login: UITextField = {
        let login = UITextField()
        login.placeholder = "Nome do Usuário"
        login.borderStyle = .roundedRect
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    private let password: UITextField = {
        let password = UITextField()
        password.placeholder = "Nova Senha"
        password.borderStyle = .roundedRect
//        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private let repeatPassword: UITextField = {
        let repeatPassword = UITextField()
        repeatPassword.placeholder = "Repita a Nova Senha"
        repeatPassword.borderStyle = .roundedRect
//        repeatPassword.isSecureTextEntry = true
        repeatPassword.translatesAutoresizingMaskIntoConstraints = false
        return repeatPassword
    }()
    
    private let changePassword: UIButton = {
        let changePassword = UIButton()
        changePassword.setTitle("Mudar Senha", for: .normal)
        changePassword.setTitleColor(.black, for: .normal)
        changePassword.backgroundColor = .systemOrange
        changePassword.layer.borderWidth = 2.5
        changePassword.layer.cornerRadius = 15
        changePassword.layer.borderColor = UIColor.black.cgColor
        changePassword.translatesAutoresizingMaskIntoConstraints = false
        return changePassword
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
    
    private let emailToken: UITextField = {
        let emailToken = UITextField()
        emailToken.placeholder = "Digite o Código de Confirmação"
        emailToken.borderStyle = .roundedRect
        emailToken.isSecureTextEntry = true
        emailToken.translatesAutoresizingMaskIntoConstraints = false
        return emailToken
    }()
    
    private let musicPlayer = Music()
    var clickpass = "clickpass"
    var soundError = "error"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        changePassword.addTarget(self, action: #selector(mudarSenha), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(voltarTela), for: .touchUpInside)
    }
    
    @objc func mudarSenha() {
        guard let loginDoUsuario = login.text, !loginDoUsuario.isEmpty,
              let newPassword = password.text, !newPassword.isEmpty,
              let repeatNewPassword = repeatPassword.text, !repeatNewPassword.isEmpty else {
            musicPlayer.playActionSound(soundFileName: soundError)
            showError(message: "Preencha os campos corretamente.")
            return
        }
        
        guard newPassword == repeatNewPassword else {
            musicPlayer.playActionSound(soundFileName: soundError)
            showError(message: "As senhas não coincidem.")
            return
        }
        
        guard newPassword.count >= 6 else {
            musicPlayer.playActionSound(soundFileName: soundError)
            showError(message: "A senha deve ter no mínimo 6 caracteres.")
            return
        }
        if let existingUser = SaveAccount.shared.getUser(login: loginDoUsuario) {
            musicPlayer.playActionSound(soundFileName: clickpass)
            existingUser.password = newPassword
            SaveAccount.shared.updateUserPassword(login: loginDoUsuario, newPassword: newPassword)
            showSuccessAndNavigate()
        } else {
            musicPlayer.playActionSound(soundFileName: soundError)
            showError(message: "Usuário não encontrado.")
        }
    }
    
    func showSuccessAndNavigate() {
        let alertController = UIAlertController(title: "Sucesso", message: "Senha alterada com sucesso!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.voltarTela()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func voltarTela() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraints() {
        view.addSubview(screenImageView)
        view.addSubview(login)
        view.addSubview(password)
        view.addSubview(repeatPassword)
        view.addSubview(changePassword)
        view.addSubview(backButton)
        view.addSubview(emailToken)
        
        NSLayoutConstraint.activate([
            
            screenImageView.topAnchor.constraint(equalTo: view.topAnchor),
            screenImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screenImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emailToken.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            emailToken.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailToken.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            login.topAnchor.constraint(equalTo: emailToken.bottomAnchor, constant: 20),
            login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            repeatPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            repeatPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            changePassword.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 10),
            changePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePassword.widthAnchor.constraint(equalToConstant: 200),
            changePassword.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: changePassword.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
