//
//  Reusable.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

protocol Reusable { }

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}
