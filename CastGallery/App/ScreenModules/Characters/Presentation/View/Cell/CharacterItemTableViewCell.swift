//
//  CharacterItemTableViewCell.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit

final class CharacterItemTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private let mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.setHeightConstraint(with: ViewValues.defaultHeightContainerCell)
        view.layer.cornerRadius = ViewValues.defaultCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setWidthConstraint(with: ViewValues.defaultHeightContainerCell)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let labelContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(
            forTextStyle: .headline,
            compatibleWith: UITraitCollection(legibilityWeight: .bold))
//        label.textColor = .systemBlue
        label.text = "NA"
        return label
    }()
    
    private let specieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "NA"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "NA"
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var task: Task<Void, Never>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    
    // MARK: - Helpers
    private func configUI() {
        selectionStyle = .none
        addSubview(mainContainerView)
        
        mainContainerView.setConstraints(
            top: topAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            pBottom: ViewValues.doublePadding,
            pLeft: ViewValues.doublePadding,
            pRight: ViewValues.doublePadding)
        
        mainContainerView.addSubview(characterImageView)
        characterImageView.setConstraints(
            top: mainContainerView.topAnchor,
            bottom: mainContainerView.bottomAnchor,
            left: mainContainerView.leftAnchor)
        
        mainContainerView.addSubview(labelContainerStackView)
        labelContainerStackView.setConstraints(
            top: mainContainerView.topAnchor,
            bottom: mainContainerView.bottomAnchor,
            left: characterImageView.rightAnchor,
            right: mainContainerView.rightAnchor,
            pTop: ViewValues.doublePadding,
            pBottom: ViewValues.doublePadding,
            pLeft: ViewValues.doublePadding)
        
        [nameLabel, specieLabel, statusLabel].forEach {
            labelContainerStackView.addArrangedSubview($0)
        }
    }
    
    func configureData(viewModel: CharacterItemViewModel) {
        nameLabel.text = viewModel.name
        specieLabel.text = viewModel.species
        statusLabel.text = viewModel.status
        setImage(viewModel: viewModel)
    }
    
    private func setImage(viewModel: CharacterItemViewModel) {
//        characterImageView.addDefaultImage()
        characterImageView.addLoadingImage()
        if let data = viewModel.imageData {
            characterImageView.setImageFromData(data: data)
        } else {
            task = Task {
                let dataImage = await viewModel.getImageData()
                characterImageView.setImageFromData(data: dataImage)
            }
        }
    }

    // MARK: - Actions
}

// MARK: - Extensions
extension CharacterItemTableViewCell: Reusable { }
