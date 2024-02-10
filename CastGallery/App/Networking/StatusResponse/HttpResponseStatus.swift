//
//  HttpResponseStatus.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

enum HttpResponseStatus {
    static let ok = 200...299
    static let clienteError = 400...499
    static let serverError = 500...599
}
