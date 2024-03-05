//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import Foundation

class TransactionListViewModel: ObservableObject {
    
    private let networkService: TransactionServiceProtocol
    private(set) var allItems: [TransactionItemViewModel] = []
    
    @Published var filteredItems: [TransactionItemViewModel] = []
    @Published var error: NetworkingError?
    @Published var isLoading = true
    @Published var isSettingData = false
    
    @Published var totalAmount: Decimal?
    
    @Published var allCategories: [Category] = []
    @Published var selectedCategory: Category? {
        didSet {
            Task {
                await updateSelectedCategoryData()
            }
        }
    }
    
    init(_ networkService: TransactionServiceProtocol = TransactionService()) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchTransactions() async {
        isLoading = true
        error = nil
        
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
        isSettingData = true
        
        allItems = itemViewModels
        
        let groupedItems = Dictionary(grouping: itemViewModels, by: { $0.category })
        
        allCategories = [Category.all]
        
        let categories = Array(groupedItems.keys).map { key in
            Category(value: key, categoryName: "\(key)")
        }.sorted { $0.value < $1.value }
        
        allCategories.append(contentsOf: categories)
        
        selectedCategory = allCategories.first
        
        isSettingData = false
    }
    
    @MainActor
    func updateSelectedCategoryData() async {
        
        guard let selectedCategory = selectedCategory else {
            return
        }
        
        isSettingData = true
        
        // Filter might be expensive operation for large data, perform it in background
        async let (filteredItems, totalAmount) = await setData(for: selectedCategory)
        
        self.filteredItems =  await filteredItems
        self.totalAmount =  await totalAmount
        
        isSettingData = false
    }
    
    private func setData(for category: Category) async -> ([TransactionItemViewModel], Decimal) {
        
        var filteredItems: [TransactionItemViewModel] = []
        
        if category.categoryName == Category.all.categoryName {
            filteredItems = self.allItems
        } else {
            filteredItems = self.allItems.filter { $0.category == category.value }
        }
        
        let amount = filteredItems.reduce(0) { result, item in
            return result + item.amount
        }
        
        return (filteredItems, amount)
    }
}
