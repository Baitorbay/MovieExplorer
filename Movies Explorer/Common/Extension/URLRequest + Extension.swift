//
//  URLRequest + Extension.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import Foundation

extension URLRequest {
    mutating func addAuthorizationToken() {
        allHTTPHeaderFields = ["Authorization": "Bearer \(Constants.apiToken)"]
    }
}
