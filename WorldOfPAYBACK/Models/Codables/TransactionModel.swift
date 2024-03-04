
import Foundation

struct TransactionModel: Codable {
	let partnerDisplayName: String
	let category: Int
	let transactionDetail: TransactionDetail
}
