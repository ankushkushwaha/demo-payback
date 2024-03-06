//
//  DataProvider.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import Foundation

protocol NetworkServiceProtocol {
    
    var urlSession: URLSessionProtocol { get }
    
    func get(_ request: URL) async throws -> (Data, URLResponse)
    
    // add POST, PUT etc here, and implement in extension for reusability
}

extension NetworkServiceProtocol {
    func get(_ request: URL) async throws -> (Data, URLResponse) {
        try await urlSession.data(request)
    }
}
