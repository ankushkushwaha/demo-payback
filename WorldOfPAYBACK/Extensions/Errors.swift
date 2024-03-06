//
//  Errors.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation

enum DataError: Error {
    case networkError
    case mockDataError
    var errorMessage: String {
        switch self {
        case .networkError:
            return String(localized: "Could not fetch data. Please try again later.")
        case .mockDataError:
            return String(localized: "Could not fetch data from mock json file.")
        }
    }
}

enum NetworkingError: Error {
    case invalidURL
    case requestFailed(description: String)
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return String(localized: "Invalid Url")
        case .requestFailed(_):
            return String(localized: "Could not fetch data. Please try again later.")
        }
    }
}
