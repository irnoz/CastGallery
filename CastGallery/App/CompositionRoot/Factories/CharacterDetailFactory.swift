//
//  CharacterDetailFactory.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

import UIKit

protocol CharacterDetailFactory {
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController
}

struct CharacterDetailFactoryImplementation: CharacterDetailFactory {
    let urlDetail: String
    let appContainer: AppContainer

    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let controller = CharacterDetailViewController()
        return controller
    }
}
