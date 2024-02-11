//
//  CharactersRepositoryImplementation.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

struct CharactersRepositoryImplementation: CharactersRepository {

    let apiClient: ApiClientService

    func fetchCharacters(urlList: String) async throws -> (info: Info, characters: [Character]) {
        let url = URL(string: urlList)
        return try await apiClient.request(url: url, type: ResultCharactersDTO.self).toDomain()
    }
    
    
}
