//
//  CharactersViewController.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit

protocol CharactersViewControllerCoordinator {
    func didSelectMenuCell(urlDetail: String)
}

final class CharactersViewController: UITableViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    // MARK: - Helpers
    private func configTableView() {
        tableView.separatorStyle = .none
        tableView.register(
            CharacterItemTableViewCell.self,
            forCellReuseIdentifier: CharacterItemTableViewCell.reuseIdentifier)
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
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
