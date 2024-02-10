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

    private let categoryMenuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Category"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(mainContainer)
        mainContainer.fillSuperView(widthPadding: 8)

        mainContainer.addSubview(categoryMenuImageView)
        categoryMenuImageView.fillSuperView()

        configureGradientForTitle()

        mainContainer.addSubview(titleLabel)
        titleLabel.setConstraints(
            bottom: mainContainer.bottomAnchor, left: mainContainer.leftAnchor,
            right: mainContainer.rightAnchor, pBottom: 8, pLeft: 8, pRight: 8
        )
    }

    private func configureGradientForTitle() {
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = self.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.darkGray.cgColor]
        gradientMaskLayer.locations = [0.6, 0.9]
        mainContainer.layer.addSublayer(gradientMaskLayer)
    }

    func configData(viewModel: HomeItemViewModel) {
        titleLabel.text = viewModel.title
        categoryMenuImageView.image = UIImage(named: viewModel.imageName)
    }
}

extension HomeItemCell: Reusable { }

