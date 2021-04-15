//
//  FeedCell.swift
//  DesafioNews
//
//  Created by Lucas Siqueira on 12/04/21.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK: Instance Properties
    
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
}

// MARK: Extension

extension FeedCell: ViewCodeProtocol {
    func setupConfiguration() {
        backgroundColor = .white
    }

    func addViewHierarchy() {
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(date)
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteImageView)
        contentView.addSubview(stackView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            favoriteImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5),
            favoriteImageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3),
            favoriteImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3),
            favoriteImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),

            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: imageView.topAnchor),
            
        ])
        
    }
}
