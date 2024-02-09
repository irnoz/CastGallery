//
//  HomeController.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit

final class HomeController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
    }
}

extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
}

