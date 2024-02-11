//
//  ApiClientServiceImplementation+RemoteImageDataService.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

extension ApiClientServiceImplementation: RemoteImageDataService {
    func request(url: URL?) async -> Data? {
        guard let url = url else { return nil }
        do {
            let (data: data, request: request) = try await session.data(from: url)
            return (data: data, request: request).data
        } catch {
            return nil
        }
    }
}
