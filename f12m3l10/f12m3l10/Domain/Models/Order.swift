// by mioe

import Foundation

struct Order: Hashable {
	let id: String = UUID().uuidString
	let status: OrdersStatusEnum
	let title: String
	let serial: String
	let from: String
	let to: String
	let date: String
}
