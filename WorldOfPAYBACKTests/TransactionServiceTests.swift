//
//  TransactionServiceTests.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha on 05/03/24.
//

import XCTest
@testable import WorldOfPAYBACK

class TransactionServiceTests: XCTestCase {
    
    var sut: TransactionService!
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchTransactionsSuccess() async throws {
        let mockSession = MockTestURLSession()
        sut = TransactionService(mockSession)
        
        let result = await sut.fetchTransactions()
        
        switch result {
        case .success(let data):
            
            XCTAssertTrue(data.count > 0)
            XCTAssertNotNil(data.first?.partnerDisplayName)
            
        case .failure(let err):
            XCTFail("Could not fetch transactions \(err)")
        }
    }
    
    func testFetchTransactionsFail() async throws {
        
        var mockSession = MockTestURLSession()
        mockSession.error = DataError.mockDataError
        
        sut = TransactionService(mockSession)
        
        let result = await sut.fetchTransactions()
        
        switch result {
        case .success(_):
            XCTFail("TransactionService Should not succeed.")
            
        case .failure(let err):
            XCTAssertEqual(DataError.mockDataError, err as! DataError)
        }
    }
}