//
//  Category.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
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
