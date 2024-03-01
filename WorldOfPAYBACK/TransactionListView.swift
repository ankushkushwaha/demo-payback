//
//  TransactionListView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import SwiftUI

struct TransactionListView: View {
    @StateObject private var networkMonitor = NetworkMonitor()
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        
        VStack {
            if !networkMonitor.isOnline {
                Text("No internet connection!")
                    .foregroundColor(.red)
            }
            
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let error = viewModel.error {
                ErrorView(errorMessage: error.errorMessage)
            } else {
                ListView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.fetchTransactions()
        }
    }
}


struct ListView: View {
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        
        NavigationView {
            
            List(viewModel.items, id: \.self) { itemViewModel in
                ListItem(viewModel: itemViewModel)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Transactions")
                            .fontWeight(.bold)
                            .font(.title)
                        Spacer()
                    }
                }
            }
        }
    }
    
}

struct ListItem: View {
    let viewModel: TransactionItemViewModel
    
    var body: some View {
        NavigationLink(destination: Text("Item \(1)")) {
            VStack {
                Text("Partner Name: \(viewModel.partnerDisplayName)")
                Text("Amount: \(viewModel.amount) \(viewModel.currency)")
                Text("Desc: \(viewModel.description)")
                Text("\(viewModel.bookingDate)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel())
    }
}
