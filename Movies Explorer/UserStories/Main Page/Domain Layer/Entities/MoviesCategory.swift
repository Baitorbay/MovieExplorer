//
//  MoviesCategory.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import Foundation

enum MoviesCategory: String, CaseIterable {
    case nowPlaying = "now_playing"
    case popular
    case topRated = "top_rated"
    case upcoming
}
