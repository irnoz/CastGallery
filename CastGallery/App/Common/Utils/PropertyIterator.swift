//
//  PropertyIterator.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

protocol PropertyIterator { }

extension PropertyIterator {
    func dictionaryProperties() -> [String: String] {
        let mirror = Mirror(reflecting: self)
        var dictionary: [String: String] = [:]

        mirror.children.forEach { property in
            dictionary[property.label ?? .empty] = property.value as? String ?? .empty
        }
        
        return dictionary
    }
}
