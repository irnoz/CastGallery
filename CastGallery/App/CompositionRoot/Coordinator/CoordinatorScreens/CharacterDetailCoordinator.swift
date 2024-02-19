//
//  CharacterDetailCoordinator.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

import UIKit

final class CharacterDetailCoordinator: Coordinator {
    var navigation: UINavigationController
    private var characterDetailFactory: CharacterDetailFactory

    init(navigation: UINavigationController, characterDetailFactory: CharacterDetailFactory) {
        self.navigation = navigation
        self.characterDetailFactory = characterDetailFactory
    }

    func start() {
        let controller = characterDetailFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension CharacterDetailCoordinator: CharacterDetailViewControllerCoordinator {
    func didTapEpisodesCell() {
        print("navigate to eprisodes")
    }
}
