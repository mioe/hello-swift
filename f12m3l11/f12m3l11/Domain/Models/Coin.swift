// by mioe

import Foundation

struct Coin: Hashable {
	let id: String = UUID().uuidString
	let text: String
	let img: String
	
	static func mock() -> [Coin] {
		return mockBase()
	}
	
	private static func mockBase() -> [Coin] {
		[
			Coin(
				text: "btc",
				img: "btc-x2"
			),
			Coin(
				text: "ltc",
				img: "ltc-x2"
			),
			Coin(
				text: "xrp",
				img: "xrp-x2"
			),
			Coin(
				text: "trx",
				img: "trx-x2"
			),
			Coin(
				text: "eth",
				img: "eth-x2"
			),
			Coin(
				text: "dsh",
				img: "dsh-x2"
			),
		]
	}
}
