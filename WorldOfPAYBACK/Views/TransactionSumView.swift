//
//  TransactionSumView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 06/03/24.
//

import SwiftUI

struct TransactionSumView: View {
    var viewModel: TransactionSumViewModel
    
    var body: some View {
        HStack {
            Text("Total Amount: ")
                .font(.system(size: 24, weight: .regular, design: .default))
            
            Spacer()
            
            Text(viewModel.sumAmountString)
                .font(.system(size: 24, weight: .bold, design: .default))
                .lineLimit(1)
        }
        .padding(10)
        .background(Color(Constants.Colors.footerColor.name))
    }
}

struct TrabsactionSumView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSumView(viewModel: TransactionSumViewModel(amount: 10.0))
    }
}
