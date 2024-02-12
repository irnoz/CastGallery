//
//  LoadCharacterDetailUseCase.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

protocol LoadCharacterDetailUseCase {
    func execute() async throws -> Character
}

struct LoadCharacterDetailUseCaseImplementation: LoadCharacterDetailUseCase {
    private(set) var characterDetailRepository: CharacterDetailRepository
    private(set) var urlDetail: String

    func execute() async throws -> Character {
        try await characterDetailRepository.fetchCharacterDetails(urlDetail: urlDetail)
    }
}
