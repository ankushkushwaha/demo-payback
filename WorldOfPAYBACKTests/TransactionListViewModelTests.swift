//
//  TransactionListViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha
//

import XCTest
@testable import WorldOfPAYBACK

class TransactionListViewModelTests: XCTestCase {
    
    var sut: TransactionListViewModel!
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchTransactionsSuccess() async {
        let mockService = MockTransactionService()
        
        sut = TransactionListViewModel(mockService)
        
        XCTAssertEqual(sut.isLoading, true)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.allItems.count, 0)
        
        await sut.fetchTransactions()
        
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.allItems.count, 21)
        
    }
    
    func testFetchTransactionsFail() async {
                
        var mockService = MockTransactionService()
        mockService.error = DataError.mockDataError

        sut = TransactionListViewModel(mockService)
        
        XCTAssertEqual(sut.isLoading, true)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.filteredItems.count, 0)
        
        await sut.fetchTransactions()
        
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.allItems.count, 0)
    }
    
    func testUpdateSelectedCategoryData() async {
        let mockService = MockTransactionService()
        
        sut = TransactionListViewModel(mockService)
        
        XCTAssertEqual(sut.isLoading, true)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.filteredItems.count, 0)
        XCTAssertEqual(sut.totalAmount, nil)
        
        await sut.fetchTransactions()
        
        // category-3 is last in mockData
        sut.selectedCategory = sut.allCategories.last
        
        await sut.updateSelectedCategoryData()
        
        XCTAssertEqual(sut.filteredItems.count, 1)
        XCTAssertEqual(sut.totalAmount, 86.0)
    }
}

struct MockTransactionService: TransactionServiceProtocol {
    var urlSession: URLSessionProtocol = MockURLSessionPlaceholder()

    var error: Error?
    
    func fetchTransactions() async -> Result<[TransactionModel], Error> {
        if let error = error {
            return .failure(error)
            
        } else if let transactionModels = MockTestModelProvider().transactionModelArray() {
            return .success(transactionModels)
        }
        
        return .failure(NetworkingError.requestFailed(description: "Mock fetchTransactions request faield"))
    }
}

struct MockURLSessionPlaceholder: URLSessionProtocol {
    func data(_ url: URL) async throws -> (Data, URLResponse) {
        fatalError("MockURLSessionPlaceHolder method called")
    }
    
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        fatalError("MockURLSessionPlaceHolder method called")
    }
}
