//
//  Origin.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

struct Origin {
    let name: String
    let url: String
}

extension Origin: CustomStringConvertible {
    var description: String {
        "\(AppLocalized.origin) \(name)"
    }
}
