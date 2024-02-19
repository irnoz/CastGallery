//
//  FilterDisplayable.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 13.02.24.
//

import UIKit

protocol FilterDisplayalbe: UIViewController {
    
}

extension FilterDisplayalbe {
    func displayFilter() {
        let filterViewController = UIViewController()
        self.present(filterViewController, animated: true, completion: nil)
    }
}
