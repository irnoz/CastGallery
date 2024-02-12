//
//  ResultCharactersDTO+Mapping.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

extension ResultCharactersDTO {
    func toDomain() -> (info: Info, characters: [Character]) {
        let charactersModel = results.map {
            let characterStatus = CharacterStatus(status: $0.status)
            let specie = Specie(specie: $0.species)
            let gender = Gender(gender: $0.gender)
            let origin = Origin(name: $0.origin.name, url: $0.origin.url)
            let location = Location(name: $0.location.name, type: $0.location.type, dimension: $0.location.dimension, url: $0.location.url)
            return Character(id: $0.id, name: $0.name, status: characterStatus, specie: specie, gender: gender, urlCharacter: $0.url, urlImage: $0.image, origin: origin, location: location)
        }
        let info = Info(next: info.next)
        
        return (info: info, characters: charactersModel)
    }
}
