//
//  HomeCoordinator.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigation: UINavigationController
    private let homeFactory: HomeFactory

    init(navigation: UINavigationController, homeFactory: HomeFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }

    func start() {
        let controller = homeFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: HomeViewControllerCoordinator {
    func didSelectMenuCell(model: MenuItem) {
        switch model.title {
        case "characters":
            goToCharacters(urlList: model.url)
        default:
            break
        }
    }
    
    private func goToCharacters(urlList: String) {
        let charactersCoordinator = homeFactory.makeCoordinatorCharacters(navigation: navigation, urlList: urlList)
        charactersCoordinator.start()
    }
}
