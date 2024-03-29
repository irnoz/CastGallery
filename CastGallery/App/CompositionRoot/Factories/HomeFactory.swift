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
    func makeCharactersCoordinator(navigation: UINavigationController, urlList: String) -> Coordinator
}

struct HomeFactoryImplementation: HomeFactory {

    let appConteiner: AppContainer

    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController {
        let apiClientService = ApiClientServiceImplementation()
        let menuRepository = MenuRepositoryImplementation(apiClientService: apiClientService, urlList: Endpoint.rickAndMortyUrl)
        let state = PassthroughSubject<StateController, Never>()
        let loadMenuUseCase = LoadMenuUseCaseImplementation(menuRepository: menuRepository)
        let homeViewModel = HomeViewModelImplementation(state: state, loadMenuUseCase: loadMenuUseCase)
        let homeController = HomeViewController(viewModel: homeViewModel, layout: makeLayout(), coordinator: coordinator)
        homeController.title = AppLocalized.appName
        return homeController
    }

    func makeCharactersCoordinator(navigation: UINavigationController, urlList: String) -> Coordinator {
        let charactersFactory = CharactersFactoryImplementation(urlList: urlList, appContainer: appConteiner)
        let charactersCoordinator = CharactersCoordinator(navigation: navigation, charactersFactory: charactersFactory)
        return charactersCoordinator
    }

    private func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (ViewValues.widthScreen - ViewValues.doublePadding) / ViewValues.multiplierTwo
        let layoutHeight = (ViewValues.widthScreen - ViewValues.doublePadding) / ViewValues.multiplierTwo
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: ViewValues.normalPadding,
                                           bottom: .zero, right: ViewValues.normalPadding)
        return layout
    }
}
