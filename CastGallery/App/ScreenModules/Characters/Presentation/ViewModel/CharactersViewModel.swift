//
//  CharactersViewModel.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit
import Combine

protocol CharactersViewModel: BaseViewModel {
    var characterItemsCount: Int { get }
    var filteredCharacterItemsCount: Int { get }
    var lastPage: Bool { get }

    func getItemMenuViewModel(row: Int, isInSearchMode: Bool) -> CharacterItemViewModel
    func getUrlDetail(row: Int, isInSearchMode: Bool) -> String
    func isInSearchMode(_ searchController: UISearchController) -> Bool
    func updateSearchController(searchBarText: String?)
}

final class CharactersViewModelImplementation: CharactersViewModel {
    var state: PassthroughSubject<StateController, Never>

    var lastPage: Bool {
        lastPageValidationUseCase.lastPage
    }
    var characterItemsCount: Int {
        characters.count
    }
    var filteredCharacterItemsCount: Int {
        filteredCharacters.count
    }

    private(set) var characters: [Character] = []
    private(set) var filteredCharacters: [Character] = []
    private let loadCharactersUseCase: LoadCharactersUseCase
    private var lastPageValidationUseCase: LastPageValidationUseCase
    private var imageDataUseCase: ImageDataUseCase

    init(
        state: PassthroughSubject<StateController, Never>,
        loadCharactersUseCase: LoadCharactersUseCase,
        lastPageValidationUseCase: LastPageValidationUseCase,
        imageDataUseCase: ImageDataUseCase
    ) {
        self.state = state
        self.loadCharactersUseCase = loadCharactersUseCase
        self.lastPageValidationUseCase = lastPageValidationUseCase
        self.imageDataUseCase = imageDataUseCase
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

    func getItemMenuViewModel(row: Int, isInSearchMode: Bool) -> CharacterItemViewModel {
        checkAndLoadMoreCharacters(row: row)
        return makeCharacteritemViewModel(row: row, isInSearchMode: isInSearchMode)
    }

    private func checkAndLoadMoreCharacters(row: Int) {
        lastPageValidationUseCase.checkAndLoadMoreItems(row: row, actualItems: characters.count, action: viewDidLoad)
    }
    
    private func makeCharacteritemViewModel(row: Int, isInSearchMode: Bool) -> CharacterItemViewModel {
        let character = isInSearchMode ? filteredCharacters[row] : characters[row]
        return CharacterItemViewModel(character: character, imageDataUseCase: imageDataUseCase)
    }

    func getUrlDetail(row: Int, isInSearchMode: Bool) -> String {
        let character = isInSearchMode ? filteredCharacters[row] : characters[row]
        return character.urlCharacter
    }
}

// MARK: - Search Functions
extension CharactersViewModelImplementation {
    public func isInSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? .empty
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        if let searchBarText = searchBarText?.lowercased() {
            guard !searchBarText.isEmpty else { viewDidLoad(); return }
//            var debounceTimer: Timer?
//            debounceTimer?.invalidate()
//            debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true)
            self.filteredCharacters = self.characters.filter({ character in
                character.name.lowercased().contains(searchBarText)
            })
        }
        
        self.viewDidLoad()
    }
}
