//
//  UIImageView+Utils.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit

extension UIImageView {
    func setImageFromData(data: Data?) {
        if let data = data {
            if let image = UIImage(data: data) {
                self.image = image
            }
        }
    }

    func addDefaultImage() {
        self.image = UIImage(named: Images.defaultImage)
    }

    func addLoadingImage() {
        self.image = UIImage(named: Images.loadingImage)
    }
}
