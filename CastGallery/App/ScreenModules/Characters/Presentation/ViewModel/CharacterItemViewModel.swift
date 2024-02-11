//
//  CharacterItemViewModel.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

struct CharacterItemViewModel {
    private let character: Character

    init(character: Character) {
        self.character = character
    }

    var naim: String {
        character.name
    }

    var species: String {
        character.specie.description
    }

    var status: String {
        character.status?.description ?? ""
    }
}
