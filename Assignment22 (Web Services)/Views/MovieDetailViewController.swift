//
//  MovieDetailViewController.swift
//  Assignment22 (Web Services)
//
//  Created by Macbook Air 13 on 25.11.23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
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
    
    private let imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "IMDb"
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = UIColor(red: 99 / 255.0, green: 115 / 255.0, blue: 148 / 255.0, alpha: 1)
        return label
    }()
    
    private let movieDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(red: 26 / 255.0, green: 34 / 255.0, blue: 50 / 255.0, alpha: 1)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsTableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
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
    
    weak var movie: Movie?
    
    
    // MARK: - Configure
    private func configure(for movie: Movie) {
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
        fillDetailsTableStackView()
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
        ratingsStackView.addArrangedSubview(imdbLabel)
    }
    
    private func setupMovieDescriptionStackView() {
        mainStackView.addArrangedSubview(movieDescriptionStackView)
    }
    
    private func fillMovieDescriptionStackView() {
        movieDescriptionStackView.addArrangedSubview(descriptionLabel)
        movieDescriptionStackView.addArrangedSubview(detailsTableStackView)
        // Adding Empty StackView for adjusting UI
        movieDescriptionStackView.addArrangedSubview(UIStackView())
    }
    
    private func fillDetailsTableStackView() {
        addDetailToDetailsTableStackView(title: "Certificate", detail: movie?.certificate ?? "")
        addDetailToDetailsTableStackView(title: "Runtime", detail: movie?.runtime ?? "")
        addDetailToDetailsTableStackView(title: "Release", detail: movie?.release ?? "")
        addDetailToDetailsTableStackView(title: "Genre", detail: movie?.genres ?? "")
        addDetailToDetailsTableStackView(title: "Director", detail: movie?.director ?? "")
        addDetailToDetailsTableStackView(title: "Cast", detail: movie?.cast ?? "")
    }
    
    private func addDetailToDetailsTableStackView(title: String, detail: String) {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Helvetica", size: 14)
        titleLabel.textColor = UIColor(red: 99 / 255.0, green: 115 / 255.0, blue: 148 / 255.0, alpha: 1)
        titleLabel.widthAnchor.constraint(equalToConstant: 74.0).isActive = true
        titleLabel.text = title
        
        let detailLabel = UILabel()
        detailLabel.font = UIFont(name: "Helvetica", size: 14)
        detailLabel.textColor = .white
        detailLabel.numberOfLines = 0
        detailLabel.text = detail
        
        let singleDetailStackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        singleDetailStackView.alignment = .leading
        singleDetailStackView.spacing = 16
        
        detailsTableStackView.addArrangedSubview(singleDetailStackView)
    }
    
    private func setupBottomSessionStackView() {
        view.addSubview(bottomSessionStackView)
        setBottomSessionStackViewConstraints()
        bottomSessionStackView.addArrangedSubview(selectSessionButton)
    }
    
    private func fillViewsWithMovieData() {
        customTitleLabel.text = movie?.title
        movieCoverImageView.image = UIImage(named: movie?.movieSceneImageName ?? "")
        ratingLabel.text = "\(movie?.imdbRating ?? 0.0)"
        descriptionLabel.text = movie?.plot
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
