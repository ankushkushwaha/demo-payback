//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {
    
    var body: some Scene {
        WindowGroup {
            
            let mockService = TransactionService(MockURLSession())
            //Inject fake server into viewModel
            TransactionListView(viewModel: TransactionListViewModel(mockService))
        }
    }
}
