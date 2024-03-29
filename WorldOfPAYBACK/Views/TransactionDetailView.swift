//
//  TransactionDetailView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import SwiftUI

struct TransactionDetailView: View {
    
    let viewModel: TransactionDetailViewModel
    
    var body: some View {
        ZStack {
            Color(Constants.Colors.detailColor.name)
                .edgesIgnoringSafeArea(.all) // Ignore safe area if needed
            
            VStack {
                Text("Partner Display Name: \(viewModel.partnerDisplayName)")
                    .font(.system(size: 20, weight: .regular))
                
                if let description = viewModel.description {
                    Text("Transaction Desctiption: \(description)")
                        .font(.system(size: 20, weight: .regular))
                }
            }
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(viewModel: TransactionDetailViewModel(displayName: "Name", description: "Description"))
    }
}
