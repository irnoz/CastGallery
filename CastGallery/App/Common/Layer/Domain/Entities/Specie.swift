//
//  Specie.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

enum Specie {
    case alien
    case human
    case other(type: String?)
    
    init(specie: String?) {
        switch specie {
        case AppLocalized.human:
            self = .human
        case AppLocalized.alien:
            self = .alien
        default:
            self = .other(type: specie)
        }
    }
}

extension Specie: CustomStringConvertible {
    var description: String {
        switch self {
        case .alien:
            return AppLocalized.specieAlien
        case .human:
            return AppLocalized.specieHuman
        case .other(let specie):
            return "\(AppLocalized.specie) \(String(describing: specie))"
        }
    }
}
