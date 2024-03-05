//
//  TransactionDetailViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha on 05/03/24.
//

import XCTest
@testable import WorldOfPAYBACK

class TransactionDetailViewModelTests: XCTestCase {
    var sut: TransactionDetailViewModel!
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInit() {
        sut = TransactionDetailViewModel(displayName: "name", description: "description")
        
        XCTAssertEqual(sut.partnerDisplayName, "name")
        XCTAssertEqual(sut.description, "description")
    }
}
