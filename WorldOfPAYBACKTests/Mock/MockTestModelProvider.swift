//
//  MockDataModelProvider.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha
//

import Foundation
@testable import WorldOfPAYBACK

struct MockTestModelProvider {
    var data: Data?
    
    init(_ jsonData: Data? = nil) {
        if let jsonData = jsonData {
            data = jsonData
        } else {
            data = MockTestJsonData().getJsonData()
        }
    }
    
    func transactionModelArray() -> [TransactionModel]? {
        guard let data = data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(TransactionListModel.self, from: data)
            return decodedData.items
        } catch {
            print(error)
            return nil
        }
    }
    
    func transactionModel() -> TransactionModel? {
        guard let model = transactionModelArray()?.first else {
            return nil
        }
        return model
    }
    
}

