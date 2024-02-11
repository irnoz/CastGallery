//
//  LocationDTO.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

struct LocationDTO: Decodable {
    let name: String
    let type: String?
    let dimension: String?
    let url: String
}
