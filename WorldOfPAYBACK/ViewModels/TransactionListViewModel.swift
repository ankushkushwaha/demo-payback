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
    
    @Published var selectedCategory: Category? {
        didSet {
            print(selectedCategory)
        }
    }
    @Published var allCategories: [Category] = []

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
            
            setupCategories()
            
        case .failure(let err):
            print(err)
            // set custom NetworkingError for better user experience.
            error = NetworkingError.requestFailed(description: err.localizedDescription)
        }
        
        isLoading = false
    }
    
    private func setupCategories() {
        
        let groupedItems = Dictionary(grouping: items, by: { $0.category })
       allCategories = Array(groupedItems.keys).map { key in
           Category(value: key)
       }.sorted { $0.value < $1.value }
        selectedCategory = allCategories.first
    }
    
}
