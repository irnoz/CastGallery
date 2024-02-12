//
//  CharacterDTO+Mapping.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

extension CharacterDTO {
    func toDomain() -> Character {
        let status = CharacterStatus(status: status)
        let specie = Specie(specie: species)
        let gender = Gender(gender: gender)
        let origin = Origin(name: origin.name, url: origin.url)
        let locaion = Location(name: location.name, type: location.type, dimension: location.dimension, url: location.url)
        return Character(id: id, name: name, status: status, specie: specie, gender: gender, urlCharacter: url, urlImage: image, origin: origin, location: locaion)
    }
}
