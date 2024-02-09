//
//  Coordinator.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}
