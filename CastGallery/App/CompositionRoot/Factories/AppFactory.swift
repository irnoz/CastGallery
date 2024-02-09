//
//  AppFactory.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit

protocol AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator
}

struct AppFactoryImplementation: AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        let fakeCoordinator = FakeCoordinator(navigation: navigation)
        return fakeCoordinator
    }
}

final class FakeCoordinator: Coordinator {
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        
    }
    
    
}
