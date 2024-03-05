//
//  MockDataModelProvider.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha on 05/03/24.
//

import Foundation
@testable import WorldOfPAYBACK

struct MockModelProvider {
    let data = """
                {
                  "partnerDisplayName" : "REWE Group",
                  "alias" : {
                    "reference" : "795357452000810"
                  },
                  "category" : 1,
                  "transactionDetail" : {
                    "description" : "Punkte sammeln",
                    "bookingDate" : "2022-07-24T10:59:05+0200",
                    "value" : {
                      "amount" : 124,
                      "currency" : "PBP"
                    }
                  }
                }
              """.data(using: .utf8)!
    
    
    func transactionModel() -> TransactionModel? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(TransactionModel.self, from: data)
           return decodedData
        } catch {
            print(error)
            return nil
        }
    }
 }

