import UIKit

class InGame: UIViewController {
    
    private let backgroundImage = ImageDefault(imageName: "backgroundimagex")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setElements()
    }
    
    private func setElements() {
        setBackgroundImage()
    }
    
    private func setBackgroundImage() {
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
    }
}
