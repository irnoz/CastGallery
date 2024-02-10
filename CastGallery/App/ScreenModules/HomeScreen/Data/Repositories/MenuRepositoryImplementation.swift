//
//  MenuRepositoryImplementation.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

import Foundation

struct MenuRepositoryImplementation: MenuRepository {

    let apiClientService: ApiClientService
    let urlList: String

    func fetchMenuData() async throws -> [MenuItem] {
        let url = URL(string: urlList)
        return try await apiClientService.request(url: url, type: MenuDTO.self).toDomain()
    }
}
