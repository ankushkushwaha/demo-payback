//
//  Category.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 04/03/24.
//

import Foundation

struct Category: Hashable {
    let value: Int
    let categoryName: String
}

extension Category {
    static var all: Category {
        Category(value: Int.max, categoryName: String(localized: "All"))
    }
}
