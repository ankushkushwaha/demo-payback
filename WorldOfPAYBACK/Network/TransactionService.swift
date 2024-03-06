//
//  TransactionService.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 01/03/24.
//

import Foundation

protocol TransactionServiceProtocol: NetworkServiceProtocol  {
    
    func fetchTransactions() async -> Result<[TransactionModel], Error>
}

struct TransactionService: TransactionServiceProtocol  {
    
    let urlSession: URLSessionProtocol
    
    // Dependency Injection to mock urlSession for testing
    init(_ urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchTransactions() async -> Result<[TransactionModel], Error> {
        
        guard let url = URL(string: Endpoints.transactions) else {
            return .failure(NetworkingError.invalidURL)
        }
        
        do {
            let (data, _) = try await get(url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(TransactionListModel.self, from: data)
            return .success(decodedData.items)
        } catch {
            return .failure(error)
        }
    }
}
