//

import UIKit

class TextFieldDefault: UITextField {
    
    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        
        initDefault(placeholder: placeholder)
        self.isSecureTextEntry = isSecure
    }
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        
        initDefault(placeholder: placeholder, keyboardType: keyboardType)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initDefault(placeholder: String, keyboardType: UIKeyboardType = .default) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.keyboardType = keyboardType
    }
}
