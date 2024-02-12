//
//  CharacterDetailViewController.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

import UIKit

protocol CharacterDetailViewControllerCoordinator {
    
}

final class CharacterDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
