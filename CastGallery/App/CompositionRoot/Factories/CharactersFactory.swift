//
//  CharactersFactory.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit
import Combine

protocol CharactersFactory {
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController
    func makeCharacterDetailCoordinator(navigation: UINavigationController, urlDetail: String) -> Coordinator
}

struct CharactersFactoryImplementation: CharactersFactory {

    let urlList: String
    let appContainer: AppContainer

    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiClient = appContainer.apiClient
        let characterRepository = CharactersRepositoryImplementation(apiClient: apiClient)
        let loadCharactersUseCase = LoadCharactersUseCaseImplementation(characterRepository: characterRepository,url: urlList)
        let lastPageValidationUseCase = LastPageValidationUseCaseImplementation()
        let viewModel = CharactersViewModelImplementation(state: state, loadCharactersUseCase: loadCharactersUseCase, lastPageValidationUseCase: lastPageValidationUseCase, imageDataUseCase: appContainer.getDataImageUseCase())
        let controller = CharactersViewController(viewModel: viewModel, coordinator: coordinator)
        controller.navigationController?.navigationBar.prefersLargeTitles = true
        controller.title = AppLocalized.charactersTitle
        return controller
    }
    
    func makeCharacterDetailCoordinator(navigation: UINavigationController, urlDetail: String) -> Coordinator {
        let characterDetailFactory = CharacterDetailFactoryImplementation(urlDetail: urlDetail, appContainer: appContainer)
        let characterDetailCoordinator = CharacterDetailCoordinator(navigation: navigation, characterDetailFactory: characterDetailFactory)
        return characterDetailCoordinator
    }
}
