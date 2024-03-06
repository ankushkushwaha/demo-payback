//
//  TransactionItemViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

struct TransactionItemViewModel: Hashable {
    let id = UUID()
    let amount: Decimal
    let currency: String
    let category: Int
    let partnerDisplayName: String
    let bookingDate: Date
    let description: String?
    
    init(_ model: TransactionModel) {
        self.amount = model.transactionDetail.value.amount
        self.category = model.category
        self.currency = model.transactionDetail.value.currency
        self.description = model.transactionDetail.description
        self.partnerDisplayName = model.partnerDisplayName
        self.bookingDate = model.transactionDetail.bookingDate
    }
}
