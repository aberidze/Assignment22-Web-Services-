//
//  MovieDetailViewController.swift
//  Assignment22 (Web Services)
//
//  Created by Macbook Air 13 on 26.11.23.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - Properties
    private let customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        label.textColor = .white
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let movieCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ratingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        return stackView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = .white
        return label
    }()
    
    private let reviewNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor(red: 99 / 255.0, green: 115 / 255.0, blue: 148 / 255.0, alpha: 1)
        return label
    }()
    
    private let movieDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(red: 26 / 255.0, green: 34 / 255.0, blue: 50 / 255.0, alpha: 1)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let plotLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        label.textColor = .white
        label.text = "PLOT:"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let bottomSessionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let selectSessionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255 / 255.0, green: 128 / 255.0, blue: 54 / 255.0, alpha: 1)
        button.setTitle("Select session", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18.0)
        button.titleLabel?.textColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var movie: MovieModel?
    
    
    // MARK: - Configure
    func configure(for movie: MovieModel) {
        self.movie = movie
    }
    
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        setupBackground()
        setupNavigationBar()
        setupMainStackView()
        fillMainStackView()
        fillRatingsStackView()
        fillViewsWithMovieData()
        setupMovieDescriptionStackView()
        fillMovieDescriptionStackView()
        setupBottomSessionStackView()
    }

    private func setupBackground() {
        view.backgroundColor = UIColor(red: 31 / 255.0, green: 41 / 255.0, blue: 61 / 255.0, alpha: 1)
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = customTitleLabel
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        setMainStackViewConstraints()
    }
    
    private func fillMainStackView() {
        mainStackView.addArrangedSubview(movieCoverImageView)
        mainStackView.addArrangedSubview(ratingsStackView)
    }
    
    private func fillRatingsStackView() {
        ratingsStackView.addArrangedSubview(ratingLabel)
        ratingsStackView.addArrangedSubview(reviewNumberLabel)
    }
    
    private func setupMovieDescriptionStackView() {
        mainStackView.addArrangedSubview(movieDescriptionStackView)
    }
    
    private func fillMovieDescriptionStackView() {
        movieDescriptionStackView.addArrangedSubview(plotLabel)
        movieDescriptionStackView.addArrangedSubview(descriptionLabel)
        // Adding Empty StackView for adjusting UI
        movieDescriptionStackView.addArrangedSubview(UIStackView())
    }
    
    private func setupBottomSessionStackView() {
        view.addSubview(bottomSessionStackView)
        setBottomSessionStackViewConstraints()
        bottomSessionStackView.addArrangedSubview(selectSessionButton)
    }
    
    private func fillViewsWithMovieData() {
        customTitleLabel.text = movie?.title
        setMovieImage(from: (movie?.posterPath ?? ""))
        ratingLabel.text = "\(round(movie?.voteAverage ?? 0))"
        reviewNumberLabel.text = "(Reviewed by \(movie?.voteCount ?? 0))"
        descriptionLabel.text = movie?.overview
    }
    
    private func setMovieImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.movieCoverImageView.image = image
            }
        }
    }
    
    
    // MARK: - Constraints
    private func setMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -88.0),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setBottomSessionStackViewConstraints() {
        NSLayoutConstraint.activate([
            bottomSessionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomSessionStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSessionStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSessionStackView.heightAnchor.constraint(equalToConstant: 88.0)
        ])
    }
}
