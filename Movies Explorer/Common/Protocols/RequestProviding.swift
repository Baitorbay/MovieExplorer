//
//  RequestProviding.swift
//  Movies Explorer
//
//  Created by Temirlan on 4.06.2023.
//

import Foundation

protocol RequestProviding {
    var urlRequest: URLRequest { get }
    var shouldAddAuthorizationToken: Bool { get }
}
