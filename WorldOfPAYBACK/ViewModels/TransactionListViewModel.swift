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
    @Published var isFiltering = false
    
    @Published var totalAmount: Decimal = 0
    
    @Published var allCategories: [Category] = []
    @Published var selectedCategory: Category? {
        didSet {
            updateFilteredData()
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
    
    private func updateFilteredData()  {
        guard let selectedCategory = selectedCategory else {
            return
        }
        
        isFiltering = true
        
        // Filter might be expensive for large data, perform in background
        DispatchQueue.global().async { [self] in
            
            var filteredItems: [TransactionItemViewModel] = []
            
            if selectedCategory.categoryName == Category.all.categoryName {
                filteredItems = self.allItems
            } else {
                filteredItems = self.allItems.filter { $0.category == selectedCategory.value }
            }
            
            let amount = filteredItems.reduce(0) { result, item in
                return result + item.amount
            }
            
            DispatchQueue.main.async {
                self.filteredItems = filteredItems
                self.totalAmount = amount
                isFiltering = false
            }
        }
    }
}
