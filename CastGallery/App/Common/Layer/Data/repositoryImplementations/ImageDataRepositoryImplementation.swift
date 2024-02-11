//
//  ImageDataRepositoryImplementation.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

struct ImageDataRepositoryImplementation: ImageDataRepository {

    private(set) var remoteDataServiece: RemoteImageDataService
    private(set) var localDataCache: LocalDataImageService

    init(remoteDataServiece: RemoteImageDataService, localDataCache: LocalDataImageService) {
        self.remoteDataServiece = remoteDataServiece
        self.localDataCache = localDataCache
    }

    func fetchData(url: URL?) async -> Data? {
        let data = await remoteDataServiece.request(url: url)
        localDataCache.save(key: url?.absoluteString ?? .empty, data: data)
        return data
    }
    
    func getFromCache(url: URL?) -> Data? {
        localDataCache.get(key: url?.absoluteString ?? .empty)
    }
}
