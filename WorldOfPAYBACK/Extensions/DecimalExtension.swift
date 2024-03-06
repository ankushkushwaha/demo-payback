//
//  DecimalExtension.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

extension Decimal {
    
    func formatCurrencyString(_ currencyCode: String) -> String? {
        Self.currencyFormatter.currencyCode = currencyCode
        
        return Self.currencyFormatter.string(from: self as NSDecimalNumber)
    }
    
    var formattedNumberString: String? {
        return Self.numberFormatter.string(from: self as NSDecimalNumber)
    }
}


extension Decimal {
    static let currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
}
