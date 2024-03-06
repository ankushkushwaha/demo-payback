//
//  TransactionListView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import SwiftUI

struct TransactionListView: View {
    @StateObject var networkMonitor: NetworkMonitor
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
            } else if viewModel.error != nil {
                ErrorViewWithRefreshButton
            } else {
                ZStack {
                    ListView(viewModel: viewModel)
                    viewModel.isSettingData ? ProgressView() : nil
                }
            }
        }
        .task {
            await viewModel.fetchTransactions()
        }
    }
    
    private var ErrorViewWithRefreshButton: some View {
        VStack {
            ErrorView(errorMessage: viewModel.error?.errorMessage ?? "")
                .padding()
            Button("Refresh") {
                Task {
                    await viewModel.fetchTransactions()
                }
            }
        }
    }
}


struct ListView: View {
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {

            NavigationView {
               
                VStack(spacing: 1) {
                    
                    CategorySelectionPicker
                    
                    List(viewModel.filteredItems, id: \.self) { itemViewModel in
                        TransactionItem(viewModel: itemViewModel)
                            .modifier(ShadowCardModifier())
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    
                    TransactionSumView
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
    
    private var CategorySelectionPicker: some View {
        HStack {
            Text("Choose Category: ")
                .font(.system(size: 20, weight: .regular))
            Picker("Choose Category: ", selection: $viewModel.selectedCategory) {
                ForEach(viewModel.allCategories, id: \.self) { category in
                    Text("\(category.categoryName)").tag(Category?.some(category))
                }
            }
            .frame(minWidth: 50)
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal, 10)
            .border(.gray)
            .padding(.horizontal, 10)
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
    }
    
    private var TransactionSumView: some View {
        HStack {
            Text("Total Amount: ")
                .font(.system(size: 24, weight: .regular, design: .default))
            
            Spacer()
            
            let totalAmount = "\(viewModel.totalAmount?.formattedNumberString ?? "-")"
            Text(totalAmount)
                .font(.system(size: 24, weight: .bold, design: .default))
                .lineLimit(1)
        }
        .padding(10)
        .background(Color(Constants.Colors.footerColor.name))
    }
}

struct ShadowCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Rectangle().fill(Color(Constants.Colors.listItemColor.name)))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 2, y: 2)
    }
}


struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(networkMonitor: NetworkMonitor(), viewModel: TransactionListViewModel())
    }
}
