//
//  HomeController.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit
import Combine

protocol HomeViewControllerCoordinator: AnyObject {
    func didSelectMenuCell(model: MenuItem)
}

final class HomeViewController: UICollectionViewController {

    private let viewModel: HomeViewModel
    private var cancellable = Set<AnyCancellable>()
    private weak var coordinator: HomeViewControllerCoordinator?

    init(viewModel: HomeViewModel, layout: UICollectionViewFlowLayout, coordinator: HomeViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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
                self?.presentAlert(message: error, title: AppLocalized.error)
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

// MARK: - CollectionViewDataSource
extension HomeViewController {
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
        cell.configureData(viewModel: viewModelCell)

        return cell
    }
}

// MARK: - CollectionViewDelegate
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.getMenuItem(indexPath: indexPath)
        coordinator?.didSelectMenuCell(model: model)
    }
}

// MARK: - Extensions
extension HomeViewController: SpinnerDisplayable { }

extension HomeViewController: MessageDisplayable { }
