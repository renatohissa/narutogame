//
//  Alert.swift
//  narutoGameX
//
//  Created by Renato Pinheiro Hissa on 14/09/23.
//

import UIKit

class Alert {

    func alert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
