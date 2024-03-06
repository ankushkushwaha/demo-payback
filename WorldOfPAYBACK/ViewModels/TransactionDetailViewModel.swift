//
//  TransactionDetailViewModel.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
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
