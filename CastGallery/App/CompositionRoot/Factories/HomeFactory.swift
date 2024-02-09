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
        let homeController = HomeController()
        homeController.title = "Rick and Morty"
        return homeController
    }
}
