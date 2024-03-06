//
//  Constants.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

struct Constants {
    
    enum Colors {
        case listItemColor
        case footerColor
        case detailColor
        
        var name: String {
            switch self {
            case .listItemColor:
                return "listItemColor"
            case .footerColor:
                return "footerColor"
            case .detailColor:
                return "detailColor"
            }
        }
    }
}
