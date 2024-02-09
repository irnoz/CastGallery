//
//  HomeItemCell.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit

final class HomeItemCell: UICollectionViewCell {
    
    private let mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(mainContainer)
        mainContainer.fillSuperView(widthPadding: 8)
//        mainContainer.setConstraints(
//            top: topAnchor, bottom: bottomAnchor,
//            left: leftAnchor, right: rightAnchor,
//            pTop: 8, pBottom: 8, pLeft: 8, pRight: 8
//        )
    }
    
}

extension HomeItemCell: Reusable { }

//final class HomeItemCell: UICollectionViewCell {
//    // MARK: - Public Properties
//
//    // MARK: - Private Properties
//
//    // MARK: - Life Cycle
//
//    override init(frame: CGRect) {
//        <#code#>
//    }
//
//    // MARK: - Helpers
//
//    // MARK: - Actions
//}
//
//// MARK: - Extensions
