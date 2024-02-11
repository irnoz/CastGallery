//
//  LocalDataImageService.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

protocol LocalDataImageService {
    func save(key: String, data: Data?)
    func get(key: String) -> Data?
}

struct LocalDataImageServiceImplementation: LocalDataImageService {

    private var dataStorage = NSCache<NSString, NSData>()

    func save(key: String, data: Data?) {
        guard let data = data else { return }
        dataStorage.setObject(data as NSData, forKey: key as NSString)
    }

    func get(key: String) -> Data? {
        dataStorage.object(forKey: key as NSString) as? Data
    }
}
