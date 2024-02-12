//
//  CharacterDetailRepository.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

protocol CharacterDetailRepository {
    func fetchCharacterDetails(urlDetail: String) async throws -> Character
}
