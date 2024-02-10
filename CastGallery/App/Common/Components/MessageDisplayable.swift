//
//  MessageDisplayable.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

import UIKit

protocol MessageDisplayable { }

extension MessageDisplayable where Self: UIViewController {
    func presentAlert(message: String, title: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        let okAction = UIAlertAction(title: AppLocalized.okButton, style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
