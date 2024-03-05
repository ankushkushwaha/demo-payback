//
//  TransactionItem.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 04/03/24.
//

import SwiftUI

struct TransactionItem: View {
    let viewModel: TransactionItemViewModel
    
    var body: some View {
        
        let detailViewModel = TransactionDetailViewModel(displayName: viewModel.partnerDisplayName,
                                                         description: viewModel.description)
        let detailView = TransactionDetailView(viewModel: detailViewModel)
        
        NavigationLink(destination: detailView) {
            VStack(spacing: 10){
                HStack(spacing: 10) {
                    Text("\(viewModel.partnerDisplayName)")
                        .font(.callout)
                        .lineLimit(1)
                    Spacer()
                    Text("\(viewModel.description ?? "-")")
                        .font(.caption)
                }
                
                HStack(spacing: 10) {
                    
                    // amount might be in fractions, show prettyStringValue
                    let amount = "\(viewModel.amount.formatCurrencyString (viewModel.currency) ?? "-")"
                    
                    Text(amount)
                        .font(.callout)
                        .lineLimit(1)
                    Spacer()
                    Text("\(viewModel.bookingDate.formatDateAccordingToRegion)")
                        .font(.caption)
                }
            }
        }
    }
}
