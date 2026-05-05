// by mioe

import Foundation

struct Coin: Hashable {
	let id: String = UUID().uuidString
	let text: String
	let img: String
	var price: String? = nil
	var diff: String? = nil
	var diffStep: String? = nil
	var up: Bool? = nil
	
	static func mock() -> [Coin] {
		return mockBase()
	}
	
	private static func mockBase() -> [Coin] {
		[
			Coin(
				text: "btc",
				img: "btc-x2",
			),
			Coin(
				text: "ltc",
				img: "ltc-x2",
				price: "0.92221",
				diff: "$1.17",
				diffStep: "+3.24%",
				up: true,
			),
			Coin(
				text: "xrp",
				img: "xrp-x2",
				price: "2.7604 USDT",
				diff: "$1.1147",
				diffStep: "0,44%",
				up: false,
			),
			Coin(
				text: "trx",
				img: "trx-x2",
				price: "2.7604 USDT",
				diff: "$0.34",
				diffStep: "+0.24%",
				up: true,
			),
			Coin(
				text: "eth",
				img: "eth-x2",
				price: "2.7604 USDT",
				diff: "$19.15",
				diffStep: "5.86%",
				up: false,
			),
			Coin(
				text: "dsh",
				img: "dsh-x2",
				price: "22.22 USDT",
				diff: "$22.23",
				diffStep: "+3.24%",
				up: true,
			),
		]
	}
}
