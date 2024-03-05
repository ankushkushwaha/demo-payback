//
//  TransactionItemViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha on 05/03/24.
//

import XCTest
@testable import WorldOfPAYBACK

class TransactionItemViewModelTests: XCTestCase {
    
    var sut: TransactionItemViewModel!
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInit() {
        guard let model = MockModelProvider().transactionModel() else {
            XCTFail("Could not get mock model")
            return
        }
        
        sut = TransactionItemViewModel(model)
        
        XCTAssertEqual(sut.partnerDisplayName, "REWE Group")
        XCTAssertEqual(sut.category, 1)
        XCTAssertEqual(sut.amount, 124)
    }
}
