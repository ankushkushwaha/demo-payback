//
//  TransactionSumViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha on 06/03/24.
//

import XCTest
@testable import WorldOfPAYBACK

class TransactionSumViewModelTests: XCTestCase {
    var sut: TransactionSumViewModel!

    func testInit() {
        let amount = Decimal(100.0)
        sut = TransactionSumViewModel(amount: amount)
        
        XCTAssertEqual(sut.sumAmountString, amount.formattedNumberString)
    }
}
