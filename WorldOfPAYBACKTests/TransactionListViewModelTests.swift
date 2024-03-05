//
//  TransactionListViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha on 05/03/24.
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
        let mockSession = MockTestURLSession()
        let mockService = TransactionService(mockSession)
        
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
        
        var mockSession = MockTestURLSession()
        mockSession.error = DataError.mockDataError
        
        let mockService = TransactionService(mockSession)
        
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
        let mockSession = MockTestURLSession()
        let mockService = TransactionService(mockSession)
        
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
