//
//  MoviesByCategoryDataSource.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import Foundation

protocol MoviesByCategoryDataSource: AnyObject {
    func getMovies(by category: String, page: Int, completion: @escaping (Result<PaginationModel<MoviePosterModel>, Error>) -> Void)
}

class MoviesByCategoryRemoteDataSource {
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
}

extension MoviesByCategoryRemoteDataSource: MoviesByCategoryDataSource {
    func getMovies(by category: String, page: Int, completion: @escaping (Result<PaginationModel<MoviePosterModel>, Error>) -> Void) {
        network.execute(MoviesCategoriesEndpoint.getMovies(category: category, page: page), completion: completion)
    }
}
