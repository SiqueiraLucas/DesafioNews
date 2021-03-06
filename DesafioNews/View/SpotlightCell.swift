//
//  SpotlightCell.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 11/04/21.
//

import UIKit

class SpotlightCell: UICollectionViewCell {
    
    // MARK: Instance Properties
    
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
    
    lazy var favoriteImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(systemName: "heart.fill")
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.tintColor = .systemOrange
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
}

// MARK: Extension

extension SpotlightCell: ViewCodeProtocol {
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
        contentView.addSubview(favoriteImageView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            favoriteImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            favoriteImageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.2),
            favoriteImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.2),
            favoriteImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
        ])
        
        stackView.setCustomSpacing(15, after: imageView)
        stackView.setCustomSpacing(2, after: subtitle)
        stackView.setCustomSpacing(10, after: date)
    }
}
