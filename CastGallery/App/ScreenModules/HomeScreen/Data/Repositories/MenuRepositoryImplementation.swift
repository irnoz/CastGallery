//
//  MenuRepositoryImplementation.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

struct MenuRepositoryImplementation: MenuRepository {
    func fetchMenuData() async throws -> [MenuItem] {
        [MenuItem(title: "categories", url: "NA")]
    }
}
