//
//  EndPoints.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import Foundation

// For complex environment configurations, we can create custom swift flags and xcconfigs and use those with schemes/targets according to our needs.

struct Endpoints {
    
#if DEBUG
    static let baseURL = "https://api-test.payback.com"
#else
    static let baseURL = "https://api.payback.com/"
#endif
    
    static var transactions: String {
        "\(Self.baseURL)/transactions"
    }
}
