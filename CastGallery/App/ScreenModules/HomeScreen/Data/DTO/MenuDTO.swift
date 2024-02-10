//
//  MenuDTO.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

// MARK: - toBeRemoved
struct MenuDTO: Decodable {
    let characters: String
    let locations: String
    let episodes: String
}

extension MenuDTO: PropertyIterator { }
