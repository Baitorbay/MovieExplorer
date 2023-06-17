//
//  MoviesByCategoryRepositoryInterface.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import Foundation

protocol MoviesByCategoryRepositoryInterface: AnyObject {
    func getMovies(by category: MoviesCategory, completion: @escaping (Result<[MoviePosterModel], Error>) -> Void)
    func getMoreMovies(completion: @escaping (Result<[MoviePosterModel], Error>) -> Void)
}
