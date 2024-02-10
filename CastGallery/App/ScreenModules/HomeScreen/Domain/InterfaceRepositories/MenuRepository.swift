//
//  MenuRepository.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

protocol MenuRepository {
    func fetchMenuData() async throws -> [MenuItem]
}
