//
//  API.swift
//  MoviesApp

import Foundation
import Alamofire

private let baseUrl = "https://api.themoviedb.org/3/movie/"
let posterUrl = "https://image.tmdb.org/t/p/original"
private let coder = JSONDecoder()
private let apiKey = "44b44e3e35e2aaecbc5db0acb907cccb"

class API {
    class func fetchMovies(_ movies: String, page: Int, onSuccess: @escaping (Results) -> Void) {
        coder.keyDecodingStrategy = .convertFromSnakeCase
        let urlStr = "\(baseUrl)\(movies)?&page=\(page)&api_key=\(apiKey)&language=pt-BR"
        guard let url = URL(string: urlStr) else {
            (fatalError("Unable to get url"))
        }
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    fatalError("Unable to parse data from api")
                }
                guard let results = try? coder.decode(Results.self, from: data) else {
                    fatalError("Unable to parse data in to json")
                }
                DispatchQueue.main.async {
                    onSuccess(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
