//
//  ApiClientService.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

import Foundation

protocol ApiClientService {
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T
}
