//
//  Gender.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

enum Gender {
    case female
    case male
    case genderless
    case unknown
    
    init(gender: String?) {
        switch gender {
        case AppLocalized.female:
            self = .female
        case AppLocalized.male:
            self = .male
        case AppLocalized.genderless:
            self = .genderless
        default:
            self = .unknown
        }
    }
}

extension Gender: CustomStringConvertible {
    var description: String {
        switch self {
        case .female:
            return AppLocalized.genderFemale
        case .male:
            return AppLocalized.genderMale
        case .genderless:
            return AppLocalized.genderless
        case .unknown:
            return AppLocalized.genderUnknown
        }
    }
}
