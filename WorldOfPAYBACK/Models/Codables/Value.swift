
import Foundation

struct Value: Codable {
	let amount: Decimal // Using Decimal instead of Int, as amount can be in decimals
	let currency: String
}

