//
//  LoadCharactersUseCase.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

protocol LoadCharactersUseCase {
    func execute() async  -> Result<[Character], Error>
}

final class LoadCharactersUseCaseImplementation: LoadCharactersUseCase {

    private let characterRepository: CharactersRepository
    private var url: String
    private var result: (info: Info, characters: [Character])?
    
    init(characterRepository: CharactersRepository, url: String, result: (info: Info, characters: [Character])? = nil) {
        self.characterRepository = characterRepository
        self.url = url
        self.result = result
    }

    func execute() async -> Result<[Character], Error> {
        guard !url.isEmpty else {
            return .success([])
        }

        do {
            let repositoryResult = try await characterRepository.fetchCharacters(urlList: url)
            url = repositoryResult.info.next ?? .empty
            return .success(repositoryResult.characters)
        } catch {
            return .failure(error)
        }
    }
}
