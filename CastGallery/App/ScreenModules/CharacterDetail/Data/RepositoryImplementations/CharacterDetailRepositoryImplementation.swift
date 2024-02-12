//
//  CharacterDetailRepositoryImplementation.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

import Foundation

struct CharacterDetailRepositoryImplementation: CharacterDetailRepository {

    private(set) var remoteService: ApiClientService

    func fetchCharacterDetails(urlDetail: String) async throws -> Character {
        let url = URL(string: urlDetail)
        let result = try await remoteService.request(url: url, type: CharacterDTO.self)
        return result.toDomain()
    }
}
