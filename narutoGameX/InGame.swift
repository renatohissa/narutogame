import UIKit

class InGame: UIViewController {
    
    private let backGroundImage: UIImageView = {
        let backGroundImage = UIImageView()
        backGroundImage.image = UIImage(named: "backgroundimagex")
        backGroundImage.contentMode = .scaleToFill
        backGroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backGroundImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(backGroundImage)
        
        NSLayoutConstraint.activate([
            
            backGroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
    }
}
