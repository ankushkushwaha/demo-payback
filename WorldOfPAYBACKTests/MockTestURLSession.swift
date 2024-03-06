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
        
        let mockData = fetchDataFromJSONFile()
        
        guard let mockData = mockData,
              let response = fakeSuccessResponse else {
                  throw DataError.mockDataError
              }
        return (mockData, response)
    }
    
    private func fetchDataFromJSONFile() -> Data? {
        guard let fileURL = Bundle.main.url(forResource: "MockData", withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            return jsonData
        } catch {
            print("Error fething data from mock json file: \(error)")
            return nil
        }
    }
    
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        // write implementation if needed, at present we are not using it in mockServer
        fatalError("Method Implementation missing.")
    }
}
