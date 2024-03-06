//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {
    
    var body: some Scene {
        WindowGroup {
            
            let mockService = TransactionService(MockURLSession())
            
            //Inject mock service into viewModel
            TransactionListView(networkMonitor: NetworkMonitor(),
                                viewModel: TransactionListViewModel(mockService))
        }
    }
}
