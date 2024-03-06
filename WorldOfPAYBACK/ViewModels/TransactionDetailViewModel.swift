//
//  TransactionDetailViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 04/03/24.
//

import Foundation

struct TransactionDetailViewModel {
    let partnerDisplayName: String
    let description: String?
    
    init(displayName: String, description: String?) {
        self.partnerDisplayName = displayName
        self.description = description
    }
}
