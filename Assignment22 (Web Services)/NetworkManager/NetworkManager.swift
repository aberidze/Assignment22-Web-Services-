//
//  NetworkManager.swift
//  Assignment22 (Web Services)
//
//  Created by Macbook Air 13 on 25.11.23.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "0ef1f9d4f31d9ebccb49105074d05775"
    
    private init() {}
    
    func fetchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("Wrong Response")
                return
            }
            
            guard let data else { return }
            
            do {
                let responseData = try JSONDecoder().decode(MovieResponseDataModel.self, from: data)
                completion(.success(responseData.results))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlString)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
