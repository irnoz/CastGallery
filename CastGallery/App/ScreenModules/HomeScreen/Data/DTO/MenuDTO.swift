//
//  MenuDTO.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

struct MenuDTO: Decodable {
    let characters: String
}

extension MenuDTO: PropertyIterator { }
