//
//  DetailViewController.swift
//  MovieAPI
//
//  Created by KOДИ on 22.05.2024.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func configure(with movie: Movie)
}

class DetailViewController: UIViewController {
    
    weak var delegate: DetailViewControllerDelegate?
    private lazy var detailView: DetailView = {
        var view = DetailView()
        delegate = view
        return view
    }()
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: movie)
        setupView()
        configureView(with: movie)
        setupContraints()
    }
    
    private func setupNavigationBar(with movie: Movie) {
        title = movie.title
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(detailView)
    }
    
    private func configureView(with movie: Movie) {
        delegate?.configure(with: movie)
    }
}

//MARK: - Constraints
private extension DetailViewController {
    func setupContraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
