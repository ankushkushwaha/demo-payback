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
                ZStack {
                    ListView(viewModel: viewModel)
                    viewModel.isSettingData ? ProgressView() : nil
                }
            }
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
    
    private var TransactionSumView: some View {
        HStack {
            Text("Total Amount: ")
                .font(.system(size: 26, weight: .regular, design: .default))
            
            Spacer()
            
            let totalAmount = "\(viewModel.totalAmount.formattedNumberString ?? "-")"
            Text(totalAmount)
                .font(.system(size: 26, weight: .bold, design: .default))
        }
        .padding()
        .background(.brown)
    }
}

struct ShadowCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Rectangle().fill(Color.white))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 2, y: 2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel())
    }
}
