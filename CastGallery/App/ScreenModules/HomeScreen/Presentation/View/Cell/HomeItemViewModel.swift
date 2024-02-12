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
        menuItem.title.capitalized
    }
    
    var imageName: String {
        menuItem.title
    }
}
