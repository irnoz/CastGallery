//
//  CharactersViewModel.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Combine

protocol CharactersViewModel: BaseViewModel {
    var characterItemsCount: Int { get }
    var lastPage: Bool { get }

    func getItemMenuViewModel(row: Int) -> CharacterItemViewModel
    func getUrlList(row: Int) -> String
}

final class CharactersViewModelImplementation: CharactersViewModel {
    var state: PassthroughSubject<StateController, Never>
    var lastPage: Bool {
        lastPageValidationUseCase.lastPage
    }
    var characterItemsCount: Int {
        characters.count
    }

    private var characters: [Character] = []
    private let loadCharactersUseCase: LoadCharactersUseCase
    private var lastPageValidationUseCase: LastPageValidationUseCase

    init(
        state: PassthroughSubject<StateController, Never>,
        loadCharactersUseCase: LoadCharactersUseCase,
        lastPageValidationUseCase: LastPageValidationUseCase
    ) {
        self.state = state
        self.loadCharactersUseCase = loadCharactersUseCase
        self.lastPageValidationUseCase = lastPageValidationUseCase
    }

    func viewDidLoad() {
        state.send(.loading)
        Task {
            await loadCharactersUseCase()
        }
    }

    private func loadCharactersUseCase() async {
        let resultUseCase = await loadCharactersUseCase.execute()
        updateStateUI(resultUseCase: resultUseCase)
    }
    
    private func updateStateUI(resultUseCase: Result<[Character], Error>) {
        switch resultUseCase {
        case .success(let characters):
            lastPageValidationUseCase.updateLastPage(itemsCount: characters.count)
            self.characters.append(contentsOf: characters)
            state.send(.succes)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }

    func getItemMenuViewModel(row: Int) -> CharacterItemViewModel {
        checkAndLoadMoreCharacters(row: row)
        return makeCharacteritemViewModel(row: row)
    }

    private func checkAndLoadMoreCharacters(row: Int) {
        lastPageValidationUseCase.checkAndLoadMoreItems(row: row, actualItems: characters.count, action: viewDidLoad)
    }
    
    private func makeCharacteritemViewModel(row: Int) -> CharacterItemViewModel {
        let character = characters[row]
        return CharacterItemViewModel(character: character)
    }

    func getUrlList(row: Int) -> String {
        let character = characters[row]
        return character.urlCharacter
    }
}
