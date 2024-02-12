//
//  CharacterDetailViewModel.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

import Foundation
import Combine

protocol CharacterDetailViewModel: BaseViewModel {
    var name: String? { get }
    var status: String { get }
    var specie: String { get }
    var gender: String { get }
    var imageData: Data? { get }
    var origin: String { get }
    var location: String { get }
}

final class CharacterDetailViewModelImplementation: CharacterDetailViewModel {
    
    var state: PassthroughSubject<StateController, Never>
    private let loadCharacterDetailUseCase: LoadCharacterDetailUseCase
    private let dataImageUseCase: ImageDataUseCase
    private var character: Character?

    var name: String? {
        character?.name ?? .empty
    }

    var status: String {
        character?.status?.description ?? .empty
    }

    var specie: String {
        character?.specie.description ?? .empty
    }

    var gender: String {
        character?.gender.description ?? .empty
    }

    var origin: String {
        character?.origin.description ?? .empty
    }

    var location: String {
        character?.location.description ?? .empty
    }

    var imageData: Data? {
        dataImageUseCase.getDataFromCache(url: character?.urlImage)
    }
    
    init(state: PassthroughSubject<StateController, Never>, loadCharacterDetailUseCase: LoadCharacterDetailUseCase, dataImageUseCase: ImageDataUseCase) {
        self.state = state
        self.loadCharacterDetailUseCase = loadCharacterDetailUseCase
        self.dataImageUseCase = dataImageUseCase
    }

    func viewDidLoad() {
        state.send(.loading)
        Task {
            do {
                let result = try await loadCharacterDetailUseCase.execute()
                character = result
                state.send(.succes)
            } catch {
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    
}
