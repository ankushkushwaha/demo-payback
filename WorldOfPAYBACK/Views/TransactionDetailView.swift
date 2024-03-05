//
//  TransactionDetailView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 04/03/24.
//

import SwiftUI

struct TransactionDetailView: View {
    
    let viewModel: TransactionDetailViewModel
    
    var body: some View {
        VStack {
            Text("Partner Display Name: \(viewModel.partnerDisplayName)")
            if let description = viewModel.description {
                Text("\nTransaction Desctiption: \(description)")
            }
        }
    }
}
