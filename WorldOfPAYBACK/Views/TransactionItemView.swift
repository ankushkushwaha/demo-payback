//
//  TransactionItemView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import SwiftUI

struct TransactionItemView: View {
    let viewModel: TransactionItemViewModel
    
    var body: some View {
        
        let detailViewModel = TransactionDetailViewModel(displayName: viewModel.partnerDisplayName,
                                                         description: viewModel.description)
        let detailView = TransactionDetailView(viewModel: detailViewModel)
        
        NavigationLink(destination: detailView) {
            VStack(spacing: 10){
                HStack(spacing: 10) {
                    Text("\(viewModel.partnerDisplayName)")
                        .font(.system(size: 16))
                        .lineLimit(1)
                    Spacer()
                    Text("\(viewModel.description ?? "")")
                        .font(.system(size: 16))
                }
                
                HStack(spacing: 10) {                    
                    Text(viewModel.amountString ?? "-")
                        .font(.system(size: 16).bold())
                        .lineLimit(1)
                    
                    Spacer()
                    Text("\(viewModel.bookingDateString)")
                        .font(.system(size: 15))
                }
            }
        }
    }
}

struct TransactionItem_Previews: PreviewProvider {
    static var previews: some View {
        
        let jsonData = """
                    {
                      "partnerDisplayName" : "REWE Group",
                      "alias" : {
                        "reference" : "795357452000810"
                      },
                      "category" : 1,
                      "transactionDetail" : {
                        "description" : "Punkte sammeln",
                        "bookingDate" : "2022-07-24T10:59:05+0200",
                        "value" : {
                          "amount" : 124,
                          "currency" : "PBP"
                        }
                      }
                    }
                  """.data(using: .utf8)!
        
        
        let decoder = JSONDecoder()
        let model = try! decoder.decode(TransactionModel.self, from: jsonData)
        
        return TransactionItemView(viewModel: TransactionItemViewModel(model))
    }
}


