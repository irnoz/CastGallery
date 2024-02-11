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
}

struct charactersFactoryImplementation: CharactersFactory {

    let urlList: String

    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiClient = ApiClientServiceImplementation()
        let characterRepository = CharactersRepositoryImplementation(apiClient: apiClient)
        let loadCharactersUseCase = LoadCharactersUseCaseImplementation(characterRepository: characterRepository, url: urlList)
        let viewModel = CharactersViewModelImplementation(state: state, loadCharactersUseCase: loadCharactersUseCase)
        let controller = CharactersViewController(viewModel: viewModel)
        controller.navigationController?.navigationBar.prefersLargeTitles = true
        controller.title = "Characters"
        return controller
    }
}
