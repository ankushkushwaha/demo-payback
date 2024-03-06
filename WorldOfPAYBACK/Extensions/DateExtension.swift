//
//  DateExtension.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

extension Date {
    var formatDateAccordingToRegion: String {
        let formattedDate = Self.dateFormatter.string(from: self)
        return formattedDate
    }
}

extension Date {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
}

