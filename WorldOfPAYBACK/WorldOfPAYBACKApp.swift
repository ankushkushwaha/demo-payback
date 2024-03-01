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
            TransactionListView(viewModel: TransactionListViewModel())
        }
    }
}
