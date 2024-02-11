//
//  CharacterStatus.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

enum CharacterStatus: String {
    case alive
    case dead
    case unknown
    
    init?(status: String?) {
        guard let status = CharacterStatus(rawValue: status?.lowercased() ?? .empty) else {
            return nil
        }
        self = status
    }
}

extension CharacterStatus: CustomStringConvertible {
    var description: String {
        switch self {
        case .alive:
            return AppLocalized.statusAlive
        case .dead:
            return AppLocalized.statusDead
        case .unknown:
            return AppLocalized.statusUnknown
        }
    }
}
