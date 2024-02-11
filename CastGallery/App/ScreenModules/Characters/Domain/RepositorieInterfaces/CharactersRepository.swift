//
//  CharactersRepository.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

protocol CharactersRepository {
    func fetchCharacters(urlList: String) async throws -> (info: Info, characters: [Character])
}
