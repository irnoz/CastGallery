//
//  CharactersViewController.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit
import Combine

protocol CharactersViewControllerCoordinator {
    func didSelectMenuCell(urlDetail: String)
}

final class CharactersViewController: UITableViewController {

    // MARK: - Public Properties
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Private Properties
    private let viewModel: CharactersViewModel

    // MARK: - Life Cycle
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configTableView()
        stateController()
    }

    // MARK: - Helpers
    private func configTableView() {
        tableView.separatorStyle = .none
        tableView.register(
            CharacterItemTableViewCell.self,
            forCellReuseIdentifier: CharacterItemTableViewCell.reuseIdentifier)
        addSpinerLastCell()
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .succes:
                    self?.tableView.reloadData()
                case .loading:
                    break
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: AppLocalized.error)
                }
            }
            .store(in: &cancellable)
    }
}

// MARK: - TableViewDataSource
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterItemTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CharacterItemTableViewCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        let itemViewModel = viewModel.getItemMenuViewModel(row: row)
        cell.configureData(viewModel: itemViewModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.isHidden = viewModel.lastPage
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterItemsCount
    }
}

extension CharactersViewController: MessageDisplayable { }
