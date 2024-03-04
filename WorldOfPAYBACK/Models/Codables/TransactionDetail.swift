

import Foundation

struct TransactionDetail: Codable {
    let description: String?
    let bookingDate: Date
    let value: Value
}
