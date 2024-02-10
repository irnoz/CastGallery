//
//  CharactersFactory.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit

protocol CharactersFactory {
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController
}

struct charactersFactoryImplementation: CharactersFactory {
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let controller = CharactersViewController()
        controller.navigationController?.navigationBar.prefersLargeTitles = true
        controller.title = "Characters"
        return controller
    }
}
