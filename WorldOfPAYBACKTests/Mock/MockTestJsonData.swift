//
//  MockTestJsonData.swift
//  WorldOfPAYBACKTests
//
//  Created by ankush kushwaha
//

import Foundation

class MockTestJsonData {
    func getJsonData() -> Data? {
        
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: "MockTestData", withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            return jsonData
        } catch {
            print("Error fething data from mock json file: \(error)")
            return nil
        }
    }
}
