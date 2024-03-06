//
//  MockTestURLSession.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha on 05/03/24.
//

import Foundation
@testable import WorldOfPAYBACK

struct MockTestURLSession: URLSessionProtocol {
    var error: Error? = nil
    
    func data(_ url: URL) async throws -> (Data, URLResponse) {
        
        if let error = error {
            throw error
        }
        
        return try await mockFetchData(url: url)
    }
    
    private func mockFetchData(url: URL) async throws -> (Data, URLResponse) {
        
        let fakeSuccessResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
        
        let mockData = MockTestJsonData().getJsonData()
        
        guard let mockData = mockData,
              let response = fakeSuccessResponse else {
                  throw DataError.mockDataError
              }
        return (mockData, response)
    }
    
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        // write implementation if needed, at present we are not using it in mockServer
        fatalError("Method Implementation missing.")
    }
}

