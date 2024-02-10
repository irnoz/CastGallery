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

// MARK: - toBeRemoved
extension HomeCoordinator: HomeViewControllerCoordinator {
    func didSelectMenuCell(model: MenuItem) {
        switch model.title {
        case "characters":
            goToCharacters()
        case "episodes":
            goToEpisodes()
        case "locations":
            goToLocations()
        default:
            break
        }
    }
    
    private func goToCharacters() {
        print("character screen")
    }
    private func goToLocations() {
        print("locations screen")
    }
    private func goToEpisodes() {
        print("episodes screen")
    }
}
