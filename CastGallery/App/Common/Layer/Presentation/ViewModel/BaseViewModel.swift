//
//  BaseViewModel.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import Combine

protocol BaseViewModel {
    var state: PassthroughSubject<StateController, Never> { get }

    func viewDidLoad()
}
