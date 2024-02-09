//
//  HomeFactory.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit

protocol HomeFactory {
    func makeModule() -> UIViewController
}

struct HomeFactoryImplementation: HomeFactory {
    
    func makeModule() -> UIViewController {
        let homeController = HomeController(collectionViewLayout: makeLayout())
        homeController.title = "Rick and Morty"
        return homeController
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = UIScreen.main.bounds.width / 2 - 8
        let layoutHeight = UIScreen.main.bounds.width / 2 - 8
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        return layout
    }
}
