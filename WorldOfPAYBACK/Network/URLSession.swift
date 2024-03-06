//
//  URLSession.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

protocol URLSessionProtocol {
    func data(_ url: URL) async throws -> (Data, URLResponse)
    
    // Method to support URLRequest
    func data(_ request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    
    func data(_ url: URL) async throws -> (Data, URLResponse) {
        let (data, response) = try await data(from: url)
        return (data, response)
    }
    
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await data(for: request)
        return (data, response)
    }
    
}

