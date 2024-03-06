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
        ZStack {
            Color(Constants.Colors.detailColor.rawValue)
                .edgesIgnoringSafeArea(.all) // Ignore safe area if needed
            
            VStack {
                Text("Partner Display Name: \(viewModel.partnerDisplayName)")
                if let description = viewModel.description {
                    Text("Transaction Desctiption: \(description)")
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
