//
//  RemoteImageDataService.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

protocol RemoteImageDataService {
    func request(url: URL?) async -> Data?
}
