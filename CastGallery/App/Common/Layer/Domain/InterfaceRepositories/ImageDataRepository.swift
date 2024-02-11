//
//  ImageDataRepository.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

protocol ImageDataRepository {
    func fetchData(url: URL?) async -> Data?
    func getFromCache(url: URL?) -> Data?
}
