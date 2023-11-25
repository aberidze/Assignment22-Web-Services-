//
//  HomeViewController.swift
//  Assignment22 (Web Services)
//
//  Created by Macbook Air 13 on 25.11.23.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        return imageView
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Profile", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14.0)
        button.backgroundColor = UIColor(red: 255 / 255.0, green: 128 / 255.0, blue: 54 / 255.0, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 77).isActive = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor(red: 26 / 255.0, green: 34 / 255.0, blue: 50 / 255.0, alpha: 1)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Now in cinemas"
        label.font = UIFont(name: "Helvetica-Bold", size: 24.0)
        label.textColor = .white
        return label
    }()
    
    private let moviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var movies = [MovieModel]()
    
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchMovies()
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        setupBackground()
        setupNavigationBar()
        setupMainStackView()
        fillMainStackView()
        configureCollectionView()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(red: 31 / 255.0, green: 41 / 255.0, blue: 61 / 255.0, alpha: 1)
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: appLogoImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        setMainStackViewConstraints()
    }
    
    private func fillMainStackView() {
        mainStackView.addArrangedSubview(headerLabel)
        mainStackView.addArrangedSubview(moviesCollectionView)
    }
    
    private func configureCollectionView() {
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
    }
    
    private func fetchMovies() {
        NetworkManager.shared.fetchMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.moviesCollectionView.reloadData()
                }
            case .failure(_):
                print("Failed")
            }
        }
    }
    
    
    // MARK: - Constraints
    private func setMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


// MARK: - CollectionView Delegate and DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(for: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieDetailViewController = MovieDetailViewController()
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        let movieClicked = movies[indexPath.row]
        movieDetailViewController.configure(for: movieClicked)
    }
}


// MARK: - FlowLayout Delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = 164.0
        let cellHeight = 278.0
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
