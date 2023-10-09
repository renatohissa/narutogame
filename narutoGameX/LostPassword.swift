import UIKit

class LostPassword: UIViewController {

    private let musicPlayer = Music()
    var clickpass = "clickpass"
    var soundError = "error"
 
    private let screenImageView = ImageDefault(imageName: "background8")

    private let login = TextFieldDefault(placeholder: "Nome do usuário", isSecure: false)
    private let password = TextFieldDefault(placeholder: "Nova Senha", isSecure: false)
    private let repeatPassword = TextFieldDefault(placeholder: "Repita a Nova Senha", isSecure: false)
    private let emailToken = TextFieldDefault(placeholder: "Digite o Código de Confirmação", keyboardType: .emailAddress)
    
    private let changePassword = ButtonDefault(title: "Mudar Senha")
    private let backButton = ButtonDefault(title: "Voltar")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        setElements()
    }
    
    private func setElements() {
        setScreenImage()
        setEmail()
        setLogin()
        setPassword()
        setRepeatPassword()
        setChangePassword()
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
    
    private func setEmail() {
        view.addSubview(emailToken)
            
        NSLayoutConstraint.activate([
            emailToken.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            emailToken.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailToken.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

    }
    
    private func setLogin() {
        view.addSubview(login)
            
        NSLayoutConstraint.activate([
            login.topAnchor.constraint(equalTo: emailToken.bottomAnchor, constant: 20),
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
    
    private func setRepeatPassword() {
        view.addSubview(repeatPassword)
        
        NSLayoutConstraint.activate([
            repeatPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            repeatPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setChangePassword() {
        view.addSubview(changePassword)

        changePassword.addTarget(self, action: #selector(mudarSenha), for: .touchUpInside)

        NSLayoutConstraint.activate([
            changePassword.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 10),
            changePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePassword.widthAnchor.constraint(equalToConstant: 200),
            changePassword.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setBackButton() {
        view.addSubview(backButton)
       
        backButton.addTarget(self, action: #selector(voltarTela), for: .touchUpInside)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: changePassword.bottomAnchor, constant: 10),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
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
    
    @objc func voltarTela() {
        navigationController?.popViewController(animated: true)
    }
}
