//
//  MenuDto+Mapper.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

extension MenuDTO {
    func toDomain() -> [MenuItem] {
        return self.dictionaryProperties().map { dictionary in
            let title = dictionary.key
            let url: String = (dictionary.value as? String) ?? String()
            return MenuItem(title: title, url: url)
        }
    }
}
