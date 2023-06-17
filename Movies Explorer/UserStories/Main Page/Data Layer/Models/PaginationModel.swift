//
//  PaginationModel.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import Foundation

struct PaginationModel<T: Decodable>: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [T]
}
