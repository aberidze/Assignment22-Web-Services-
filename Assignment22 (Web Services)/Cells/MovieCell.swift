//
//  MovieCell.swift
//  Assignment22 (Web Services)
//
//  Created by Macbook Air 13 on 25.11.23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let movieCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 16.0)
        label.textColor = .white
        return label
    }()
    
    private let movieGenresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textColor = UIColor(red: 99 / 255.0, green: 115 / 255.0, blue: 148 / 255.0, alpha: 1)
        return label
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        button.tintColor = .systemRed
        return button
    }()
    
    private let movieRatingsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 127, y: 4, width: 33, height: 23))
        label.backgroundColor = UIColor(red: 255 / 255.0, green: 128 / 255.0, blue: 54 / 255.0, alpha: 1)
        label.font = UIFont(name: "Helvetica-Bold", size: 12.0)
        label.textColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        return label
    }()
    
    weak var delegate: HomeViewControllerDelegate?
    
    
    // MARK: - Configure
    func configureCell(for movie: Movie) {
        movieCoverImageView.image = UIImage(named: movie.coverImageName)
        movieTitleLabel.text = movie.title
        movieGenresLabel.text = movie.genres
        movieRatingsLabel.text = "\(movie.imdbRating)"
        
        if movie.isFavorite {
            favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    // MARK: - Cell Life Cycle
    override func prepareForReuse() {
        
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        setupMainStackView()
        fillMainStackView()
        fillTitleStackView()
        addOverlayViewsToCell()
        setFavoriteButtonAction()
    }
    
    private func setupMainStackView() {
        addSubview(mainStackView)
        setMainStackViewConstraints()
    }
    
    private func fillMainStackView() {
        mainStackView.addArrangedSubview(movieCoverImageView)
        mainStackView.addArrangedSubview(titleStackView)
    }
    
    private func fillTitleStackView() {
        titleStackView.addArrangedSubview(movieTitleLabel)
        titleStackView.addArrangedSubview(movieGenresLabel)
    }
    
    private func addOverlayViewsToCell() {
        addSubview(favoritesButton)
        addSubview(movieRatingsLabel)
    }
    
    private func setFavoriteButtonAction() {
        favoritesButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.changeMovieFavoriteStatus(for: self)
        }), for: .touchUpInside)
    }
    
    
    // MARK: - Constraints
    private func setMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
