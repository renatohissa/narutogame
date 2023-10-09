//

import UIKit

class ImageDefault: UIImageView {
    
    init(imageName: String, userInteraction: Bool = false) {
        super.init(frame: .zero)
        
        defaultInit(imageName: imageName)
        self.isUserInteractionEnabled = userInteraction

    }
    
    init(imageName: String, userInterection: Bool = false, countImagens: Int) {
        super.init(frame: .zero)
        
        moveInit(imageName: imageName, countImagens: countImagens)
        self.isUserInteractionEnabled = userInterection
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defaultInit(imageName: String) {
        self.image = UIImage(named: imageName)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleToFill
    }
    
    private func moveInit(imageName: String, countImagens: Int) {
                
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleToFill
        var currentImageIndex = 0
        var sasukeMoveImages: [UIImage?] = []
        
        for i in 1...countImagens {
            let imageNameWithIndex = "\(imageName)\(i)"
            let image = UIImage(named: imageNameWithIndex)
            sasukeMoveImages.append(image)
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            currentImageIndex = (currentImageIndex + 1) % sasukeMoveImages.count
            self.image = sasukeMoveImages[currentImageIndex]
        }
    }
}
