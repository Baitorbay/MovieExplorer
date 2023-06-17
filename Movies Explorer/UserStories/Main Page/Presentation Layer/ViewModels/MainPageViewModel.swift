//
//  MainPageViewModel.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import Foundation

class MainPageViewModel {
    private let repository: MoviesByCategoryRepositoryInterface
    private(set) var sections: [Section] = []
    
    var didGetMovies: (() -> Void)?
    var didGetError: ((String) -> Void)?
    
    enum Section {
        case nowPlaying(movies: [MoviePosterModel])
        case popular(movies: [MoviePosterModel])
        case topRated(movies: [MoviePosterModel])
        case upcoming(movies: [MoviePosterModel])
        
        var title: String {
            switch self {
            case .nowPlaying:
                return "Now Playing"
            case .popular:
                return "Popular"
            case .topRated:
                return "Top Rated"
            case .upcoming:
                return "Upcoming"
            }
        }
    }
    
    init(repository: MoviesByCategoryRepositoryInterface) {
        self.repository = repository
    }
    
    func getAllCategoriesMovies() {
        repository.getMovies(by: .nowPlaying) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.sections.append(.nowPlaying(movies: movies))
                
                DispatchQueue.main.async {
                    self.didGetMovies?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.didGetError?(error.localizedDescription)
                }
            }
        }
    }
}
