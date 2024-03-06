//
//  TransactionSumViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 06/03/24.
//

import Foundation

struct TransactionSumViewModel {
    let sumAmountString: String
    
    init(amount: Decimal?) {
        sumAmountString = amount?.formattedNumberString ?? "-"
    }
}
