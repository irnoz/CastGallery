//
//  ImageDataUseCase.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

protocol ImageDataUseCase {
    func getData(url: URL?) async -> Data?
    func getDataFromCache(url: String?) -> Data?
}

struct ImageDataUseCaseImplementation: ImageDataUseCase {
    private(set) var imageDataRepository: ImageDataRepository

    func getData(url: URL?) async -> Data? {
        await imageDataRepository.fetchData(url: url)
    }
    
    func getDataFromCache(url: String?) -> Data? {
        imageDataRepository.getFromCache(url: url)
    }
}
