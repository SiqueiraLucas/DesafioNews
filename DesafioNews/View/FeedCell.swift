//
//  FeedCell.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 12/04/21.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK: Instance Properties
    
    weak var delegate: CellDelegate?
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Aves sabem voar"
        view.font = view.font.withSize(14)
        view.textColor = .label
        return view
    }()
    
    lazy var subtitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Pesquisas indicam que as asas são o motivo"
        view.numberOfLines = 2
        view.font = view.font.withSize(13)
        view.textColor = .secondaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var date: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "20/10/2020"
        view.font = view.font.withSize(12)
        view.textColor = .tertiaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.tintColor = .systemRed
        view.addTarget(self, action: #selector(favoriteButtonAction(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillProportionally
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Init

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    @objc func favoriteButtonAction(_ sender: Any) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        let imageName = favoriteButton.isSelected ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        delegate?.didTapFavorite(self)
    }
}

// MARK: Extension

extension FeedCell: ViewCode {
    func setupConfiguration() {
        backgroundColor = .white
    }

    func addViewHierarchy() {
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(date)
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(stackView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            favoriteButton.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.4),
            favoriteButton.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.4),

            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: imageView.topAnchor),
            
        ])
        
    }
}


protocol CellDelegate: class {
    func didTapFavorite(_ cell: UICollectionViewCell)
    func didTapShare(_ cell: UICollectionViewCell)
}
