//
//  HomeFactory.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit
import Combine

protocol HomeFactory {
    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController
}

struct HomeFactoryImplementation: HomeFactory {

    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController {
        let apiClientService = ApiClientServiceImplementation()
        let menuRepository = MenuRepositoryImplementation(apiClientService: apiClientService, urlList: Endpoint.baseUrl)
        let state = PassthroughSubject<StateController, Never>()
        let loadMenuUseCase = LoadMenuUseCaseImplementation(menuRepository: menuRepository)
        let homeViewModel = HomeViewModelImplementation(state: state, loadMenuUseCase: loadMenuUseCase)
        let homeController = HomeController(viewModel: homeViewModel, layout: makeLayout(), coordinator: coordinator)
        homeController.title = "Rick and Morty"
        return homeController
    }

    private func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (UIScreen.main.bounds.width - 16) / 2
        let layoutHeight = (UIScreen.main.bounds.width - 16) / 2
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: 8)
        return layout
    }
}
