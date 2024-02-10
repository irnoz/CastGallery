//
//  HomeController.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit
import Combine

final class HomeController: UICollectionViewController {

    private let viewModel: HomeViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel, layout: UICollectionViewFlowLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
        stateController()
        viewModel.viewDidLoad()
    }

    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
            switch state {
            case .succes:
                self?.collectionView.reloadData()
            case .loading:
                self?.showSpinner()
            case .fail(error: let error):
                self?.presentAlert(message: error, title: "Error")
            }
        }.store(in: &cancellable)
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
    }

    private func configureCollectionView() {
        collectionView.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.reuseIdentifier)
    }
}

extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.menuItemsCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeItemCell.reuseIdentifier, for: indexPath) as? HomeItemCell
        else {
            return UICollectionViewCell()
        }

        let viewModelCell = viewModel.getMenuItemViewModel(indexPath: indexPath)
        cell.configData(viewModel: viewModelCell)

        return cell
    }
}

extension HomeController: SpinnerDisplayable { }

extension HomeController: MessageDisplayable { }
