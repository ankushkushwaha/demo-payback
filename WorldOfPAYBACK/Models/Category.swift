//
//  Category.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 04/03/24.
//

import Foundation

struct Category: Hashable {
    let value: Int
}

extension Category {
    var categoryName: String {
        "Category \(value)"
    }
}
