//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import Foundation

class TransactionListViewModel: ObservableObject {
    
    @Published var items: [TransactionItemViewModel] = []
    @Published var error: NetworkingError?
    @Published var isLoading = true
    
    private let networkService: TransactionServiceProtocol
    
    init(networkService: TransactionServiceProtocol = TransactionService(MockURLSession())) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchTransactions() async {
        isLoading = true
        
        let result = await networkService.fetchTransactions()
        
        switch result {
        case .success(let data):
            
            let transactionItemViewModels = data.map { transactionModel in
                TransactionItemViewModel(transactionModel)
            }.sorted { $0.bookingDate > $1.bookingDate }
            
            items = transactionItemViewModels
            
        case .failure(let err):
            print(err)
            // set custom NetworkingError for better user experience.
            error = NetworkingError.requestFailed(description: err.localizedDescription)
        }
        
        isLoading = false
    }
    
    private func categories() {
        
    }
    
}
