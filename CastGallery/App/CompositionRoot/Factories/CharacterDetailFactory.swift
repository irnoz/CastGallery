//
//  CharacterDetailFactory.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

import UIKit
import Combine

protocol CharacterDetailFactory {
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController
}

struct CharacterDetailFactoryImplementation: CharacterDetailFactory {
    let urlDetail: String
    let appContainer: AppContainer

    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let characterDetailRepository = CharacterDetailRepositoryImplementation(remoteService: appContainer.apiClient)
        let loadCharacterDetailUseCase = LoadCharacterDetailUseCaseImplementation(characterDetailRepository: characterDetailRepository, urlDetail: urlDetail)
        let viewModel = CharacterDetailViewModelImplementation( state: state, loadCharacterDetailUseCase: loadCharacterDetailUseCase, dataImageUseCase: appContainer.getDataImageUseCase())
        let controller = CharacterDetailViewController(viewModel: viewModel, coordinator: coordinator)
        return controller
    }
}
