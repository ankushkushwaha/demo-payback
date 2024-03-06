//
//  TransactionItemViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

struct TransactionItemViewModel: Hashable {
    let currency: String
    let amount: Decimal
    let amountString: String?
    let category: Int
    let partnerDisplayName: String
    let bookingDate: Date
    let bookingDateString: String
    let description: String?

    init(_ model: TransactionModel) {
        currency = model.transactionDetail.value.currency
        amount = model.transactionDetail.value.amount
        amountString = amount.formatCurrencyString(currency)

        category = model.category
        partnerDisplayName = model.partnerDisplayName
        
        bookingDate = model.transactionDetail.bookingDate
        bookingDateString = bookingDate.formatDateAccordingToRegion
        
        description = model.transactionDetail.description
    }
}
