//
//  HomeMenuItemViewModel.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 10.02.24.
//

struct HomeItemViewModel {
    private let menuItem: MenuItem

    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }

    var title: String {
        "Rick and Morty\n\(menuItem.title.capitalized)"
    }
    
    var imageName: String {
        menuItem.title
    }
}
