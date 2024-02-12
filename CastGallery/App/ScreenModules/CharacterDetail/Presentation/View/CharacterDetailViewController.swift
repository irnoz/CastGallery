//
//  CharacterDetailViewController.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 12.02.24.
//

import UIKit
import Combine

protocol CharacterDetailViewControllerCoordinator {
    func didTapExpendableButton()
}

final class CharacterDetailViewController: UIViewController {
    // MARK: - Private properties
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: CharacterDetailViewModel
    private let coordinator: CharacterDetailViewControllerCoordinator
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addDefaultImage()
        imageView.contentMode = .scaleAspectFill
        imageView.setHeightConstraint(with: UIScreen.main.bounds.width)
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = ViewValues.defaultCornerRadius * ViewValues.multiplierTwo
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: NA"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var statusLabel: UILabel = makeGrayLabel(text: "Status: NA")
    
    private lazy var specieLabel: UILabel = makeGrayLabel(text: "Specie: NA")
    
    private lazy var genderLabel: UILabel = makeGrayLabel(text: "Gender: NA")
    
    private lazy var originLabel: UILabel = makeGrayLabel(text: "Origin: NA")
    
    private lazy var locationLabel: UILabel = makeGrayLabel(text: "Location: NA")
    
    private lazy var episodesButton: UIButton = makeExpandableButton(
        title: "Episodes: ", subTitle: "NA")
    
    // MARK: - Life Cycle
    init(viewModel: CharacterDetailViewModel, coordinator: CharacterDetailViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        stateController()
        configButton()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(characterImageView)
        characterImageView.setConstraints(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor, right: view.rightAnchor)
        
        view.addSubview(containerView)
        containerView.setConstraints(
            top: characterImageView.bottomAnchor,
            bottom: view.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            pTop: ViewValues.containerDetailPadding
        )
        
        containerView.addSubview(nameLabel)
        nameLabel.setConstraints(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            pTop: ViewValues.normalPadding)
        
        containerView.addSubview(statusLabel)
        statusLabel.setConstraints(
            top: nameLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            pTop: ViewValues.smallPadding)
        
        containerView.addSubview(specieLabel)
        specieLabel.setConstraints(
            top: statusLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            pTop: ViewValues.smallPadding)
        
        containerView.addSubview(genderLabel)
        genderLabel.setConstraints(
            top: specieLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            pTop: ViewValues.smallPadding)
        
        containerView.addSubview(originLabel)
        originLabel.setConstraints(
            top: genderLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            pTop: ViewValues.smallPadding)
        
        
        containerView.addSubview(locationLabel)
        locationLabel.setConstraints(
            top: originLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            pTop: ViewValues.smallPadding)
        
        let buttonStackView = UIStackView(arrangedSubviews: [episodesButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = ViewValues.normalPadding
        containerView.addSubview(buttonStackView)
        buttonStackView.setConstraints(
            top: locationLabel.bottomAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            pTop: ViewValues.normalPadding,
            pLeft: ViewValues.doublePadding,
            pRight: ViewValues.doublePadding)
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                case .succes:
                    self?.configData()
                case .loading:
                    self?.showSpinner()
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: "Error")
                }
            }.store(in: &cancellable)
    }
    
    private func configData() {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        specieLabel.text = viewModel.specie
        originLabel.text = viewModel.origin
        genderLabel.text = viewModel.gender
        locationLabel.text = viewModel.location
        characterImageView.setImageFromData(data: viewModel.imageData)
//        episodesButton.configuration?.subtitle = viewModel.episodes
    }
    
    private func configButton() {
        episodesButton.addTarget(self, action: #selector(didTapExpendableButton), for: .touchUpInside)
    }
    
    private func makeGrayLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }
    
    private func makeExpandableButton(title: String, subTitle: String) -> UIButton {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.subtitle = subTitle
        configuration.buttonSize = .small
        configuration.titleAlignment = .center
        configuration.cornerStyle = .large
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        
        configuration.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return outgoing
        }
        
        button.configuration = configuration
        return button
    }
    
    // MARK: - Actions
    @objc func didTapExpendableButton() {
        print("expand episodes button")
    }
}

// MARK: - SpinnerDisplayable
extension CharacterDetailViewController: SpinnerDisplayable { }

// MARK: - MessageDisplayable
extension CharacterDetailViewController: MessageDisplayable { }
