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
            VStack {
                
                CategorySelectionPicker
                
                List(viewModel.filteredItems, id: \.self) { itemViewModel in
                    TransactionItem(viewModel: itemViewModel)
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
    
    private var CategorySelectionPicker: some View {
        HStack {
            Spacer()
            Text("Choose Category: ")
            Picker("Choose Category:", selection: $viewModel.selectedCategory) {
                ForEach(viewModel.allCategories, id: \.self) { category in
                    Text("\(category.categoryName)").tag(Category?.some(category))
                }
            }
            .frame(minWidth: 50)
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal, 10)
            .border(.gray)
            .padding(.horizontal, 10)
        }
    }
}

struct TransactionItem: View {
    let viewModel: TransactionItemViewModel
    
    var body: some View {
        
        let detailViewModel = TransactionDetailViewModel(displayName: viewModel.partnerDisplayName,
                                                         description: viewModel.description)
        let detailView = TransactionDetailView(viewModel: detailViewModel)
        
        NavigationLink(destination: detailView) {
            VStack {
                Text("Partner Name: \(viewModel.partnerDisplayName)")
                Text("Amount: \(viewModel.amount) \(viewModel.currency)")
                Text("Desc: \(viewModel.description ?? "-")")
                
                Text("\(viewModel.bookingDate) Category: \(viewModel.category)")
                Text("Category: \(viewModel.category)")
            }
        }
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel())
    }
}
