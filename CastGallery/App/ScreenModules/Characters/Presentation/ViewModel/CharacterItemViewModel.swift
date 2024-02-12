//
//  CharacterItemViewModel.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Foundation

struct CharacterItemViewModel {
    private(set) var character: Character
    private(set) var imageDataUseCase: ImageDataUseCase

    init(character: Character, imageDataUseCase: ImageDataUseCase) {
        self.character = character
        self.imageDataUseCase = imageDataUseCase
    }

    var name: String {
        character.name
    }

    var species: String {
        character.specie.description
    }

    var status: String {
        character.status?.description ?? ""
    }

    var imageData: Data? {
        imageDataUseCase.getDataFromCache(url: character.urlImage)
    }

    func getImageData() async -> Data? {
        let url = URL(string: character.urlImage ?? .empty)
        return await imageDataUseCase.getData(url: url)
    }
}
