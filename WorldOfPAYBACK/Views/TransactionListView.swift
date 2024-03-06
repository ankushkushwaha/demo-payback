//
//  TransactionListView.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var networkMonitor: NetworkMonitor
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
                    ListWithPickerAndSumView
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
    
    private var ListWithPickerAndSumView: some View {
        
        NavigationView {
            
            VStack(spacing: 1) {
                
                CategorySelectionPicker
                
                List(viewModel.filteredItems, id: \.self) { itemViewModel in
                    TransactionItemView(viewModel: itemViewModel)
                        .modifier(ShadowCardModifier())
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                TransactionSumView(viewModel: TransactionSumViewModel(amount: viewModel.totalAmount))
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
