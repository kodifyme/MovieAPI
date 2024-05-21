//
//  TitleTableViewCell.swift
//  MovieAPI
//
//  Created by KOДИ on 16.05.2024.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
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
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }
            task.resume()
        }
    }
}

//MARK: - Constraints
private extension TitleTableViewCell {
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
