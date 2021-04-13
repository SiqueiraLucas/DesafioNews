//
//  SpotlightCell.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit

class SpotlightCell: UICollectionViewCell {
    
    // MARK: Instance Properties
    
    weak var delegate: CellDelegate?
    
    lazy var tagline: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        view.textColor = .systemOrange
        view.text = "DESTAQUE"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.preferredFont(forTextStyle: .title2)
        view.textColor = .label
        view.text = "Peixes aprendem a nadar"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subtitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.preferredFont(forTextStyle: .title3)
        view.textColor = .secondaryLabel
        view.text = "Na água"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var date: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "10/10/2020"
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
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
    
    lazy var separator: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .quaternaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
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

extension SpotlightCell: ViewCode {
    func setupConfiguration() {
        backgroundColor = .white
    }

    func addViewHierarchy() {
        stackView.addArrangedSubview(tagline)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(date)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(separator)
        contentView.addSubview(stackView)
        contentView.addSubview(favoriteButton)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            favoriteButton.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.2),
            favoriteButton.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.2)
            
        ])
        
        stackView.setCustomSpacing(15, after: imageView)
        stackView.setCustomSpacing(2, after: subtitle)
        stackView.setCustomSpacing(10, after: date)
    }
}
