//
//  HomeViewMode.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

import Combine
import Foundation

protocol HomeViewMode {
    var state: PassthroughSubject<StateController, Never> { get }
    var menuItemsCount: Int { get }

    func viewDidLoad()
    func getMenuItemViewModel(indexPath: IndexPath) -> HomeMenuItemViewModel
    func getMenuItem(indexPath: IndexPath) -> MenuItem
}

final class HomeViewModeImplementation: HomeViewMode {
    var state: PassthroughSubject<StateController, Never>

    var menuItemsCount: Int {
        menuItems.count
    }

    private let loadMenuUseCase: LoadMenuUseCase
    private var menuItems: [MenuItem] = []

    init(state: PassthroughSubject<StateController, Never>, loadMenuUseCase: LoadMenuUseCase) {
        self.state = state
        self.loadMenuUseCase = loadMenuUseCase
    }

    func viewDidLoad() {
        state.send(.loading)
        Task {
            let result = await loadMenuUseCase.execute()
            switch result {
            case .success(let menuItems):
                self.menuItems = menuItems
                state.send(.succes)
            case .failure(let error):
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }

    func getMenuItemViewModel(indexPath: IndexPath) -> HomeMenuItemViewModel {
        let menuItem = menuItems[indexPath.row]
        return HomeMenuItemViewModel(menuItem: menuItem)
    }

    func getMenuItem(indexPath: IndexPath) -> MenuItem {
        menuItems[indexPath.row]
    }
}
