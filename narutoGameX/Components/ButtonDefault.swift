//

import UIKit

class ButtonDefault: UIButton {
    
    init(title: String, titleColor: UIColor = .black) {
        super.init(frame: .zero)
        
        defaultInit(title: title, titleColor: titleColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defaultInit(title: String, titleColor: UIColor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.backgroundColor = .systemOrange
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.5
        self.layer.cornerRadius = 15
    }
}
