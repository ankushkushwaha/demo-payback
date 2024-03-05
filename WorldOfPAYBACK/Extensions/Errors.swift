//
//  Errors.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha on 29/02/24.
//

import Foundation

enum DataError: Error {
    case networkError
    case mockDataError
    var errorMessage: String {
        switch self {
        case .networkError:
            return "Could not fetch data. Please try again later."
        case .mockDataError:
            return "Could not fetch data from mock json file."
        }
    }
}

enum NetworkingError: Error {
    case invalidURL
    case requestFailed(description: String)
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid Url."
        case .requestFailed(_):
            return "Could not fetch data. Please try again later."
        }
    }
}
