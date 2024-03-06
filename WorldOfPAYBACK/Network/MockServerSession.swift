//
//  MockUrlSession.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

struct MockURLSession: URLSessionProtocol {
    
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        // write implementation if needed, at present we are not using it in mockServer
        fatalError("Method Implementation missing.")
    }
    
    func data(_ url: URL) async throws -> (Data, URLResponse) {
        try await mockFetchData(url: url)
    }
    
    private func mockFetchData(url: URL) async throws -> (Data, URLResponse) {
        
        // Simulate fake network delay of 1 second.
        try await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
        
        if let randomElement = (1...3).randomElement(),
           randomElement == 1 { // mock error
            throw DataError.mockDataError
        }
        
        let fakeSuccessResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
        
        let mockData = MockJsonData().getJsonData()
        
        guard let mockData = mockData,
              let response = fakeSuccessResponse else {
                  throw DataError.mockDataError
              }
        return (mockData, response)
    }    
}


struct MockJsonData {
    func getJsonData() -> Data? {
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
}
