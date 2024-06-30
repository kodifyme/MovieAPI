//
//  DetailView.swift
//  MovieAPI
//
//  Created by KOДИ on 22.05.2024.
//

import UIKit

class DetailView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImageView, overviewLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(itemsStackView)
    }
}

//MARK: - DetailViewControllerDelegate
extension DetailView: DetailViewControllerDelegate {
    func configure(with movie: Movie) {
        overviewLabel.text = movie.overview
        if let posterPath = movie.posterPath {
            NetworkManager.shared.fetchImages(posterPath: posterPath) { [weak self] reuslt in
                switch reuslt {
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
private extension DetailView {
    func setupContraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            itemsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            itemsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            itemsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            itemsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            itemsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            posterImageView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}
