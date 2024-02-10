//
//  CharactersCoordinator.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit

final class CharactersCoordinator: Coordinator {
    var navigation: UINavigationController
    private var charactersFactory: CharactersFactory

    init(navigation: UINavigationController, charactersFactory: CharactersFactory) {
        self.navigation = navigation
        self.charactersFactory = charactersFactory
    }

    func start() {
        let controller = charactersFactory.makeModule(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

extension CharactersCoordinator: CharactersViewControllerCoordinator {
    func didSelectMenuCell(urlDetail: String) {
        print("navigate to detail")
    }
}
