//
//  SearchTableViewCell.swift
//  MovieAPI
//
//  Created by KOДИ on 22.05.2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(posterLabel)
    }
    
    func configure(with model: Movie) {
        
        posterLabel.text = model.title
        
        if let posterPath = model.posterPath {
            NetworkManager.shared.fetchImages(posterPath: posterPath) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.posterImageView.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: - Constraints
private extension SearchTableViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            posterLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            posterLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            posterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
