//
//  CharacterDTO.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let image: String?
    let url: String
    let origin: OriginDTO
    let location: LocationDTO
}
