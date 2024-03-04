//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import Foundation

class TransactionListViewModel: ObservableObject {
    
    private let networkService: TransactionServiceProtocol
    private var allItems: [TransactionItemViewModel] = []

    @Published var filteredItems: [TransactionItemViewModel] = []
    @Published var error: NetworkingError?
    @Published var isLoading = true
    
    @Published var allCategories: [Category] = []
    @Published var selectedCategory: Category? {
        didSet {
            guard let selected = selectedCategory else {
                return
            }
            
            if selected.categoryName == Category.all.categoryName {
                filteredItems = allItems
            } else {
                filteredItems = allItems.filter { $0.category == selected.value }
            }
        }
    }
        
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
            
            setupData(transactionItemViewModels)
            
        case .failure(let err):
            print(err)
            // set custom NetworkingError for better user experience.
            error = NetworkingError.requestFailed(description: err.localizedDescription)
        }
        
        isLoading = false
    }
    
    private func setupData(_ itemViewModels: [TransactionItemViewModel]) {
        
        allItems = itemViewModels
        
        let groupedItems = Dictionary(grouping: itemViewModels, by: { $0.category })
        
        allCategories = [Category.all]
        
        let categories = Array(groupedItems.keys).map { key in
            Category(value: key, categoryName: "\(key)")
        }.sorted { $0.value < $1.value }
        
        allCategories.append(contentsOf: categories)
        
        selectedCategory = allCategories.first
    }
}
