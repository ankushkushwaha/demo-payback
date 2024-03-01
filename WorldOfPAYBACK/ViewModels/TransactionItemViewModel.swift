//
//  TransactionItemViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import Foundation

struct TransactionItemViewModel: Hashable {
    let id = UUID()
    let amount: Int
    let currency: String
    let description: String
    let partnerDisplayName: String
    let bookingDate: Date

    init(_ model: TransactionModel) {
        self.amount = model.transactionDetail.value.amount
        self.currency = model.transactionDetail.value.currency
        self.description = model.transactionDetail.description ?? ""
        self.partnerDisplayName = model.partnerDisplayName
        self.bookingDate = model.transactionDetail.bookingDate
    }
}
