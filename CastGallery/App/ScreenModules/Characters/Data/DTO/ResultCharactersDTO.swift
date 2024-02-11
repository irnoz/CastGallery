//
//  ResultCharactersDTO.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

struct ResultCharactersDTO: Decodable {
    let info: InfoDTO
    let results: [CharacterDTO]
}
