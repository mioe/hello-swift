// by mioe

import Foundation

struct Favorite: Hashable {
	let id: String = UUID().uuidString
	let coin: Coin
	let diffStep: String
	let balance: String
	let diff: String
	let up: Bool
	
	static func mock() -> [Favorite] {
		return mockBase()
	}
	
	private static func mockBase() -> [Favorite] {
		[
			Favorite(
				coin: Coin(
					text: "btc",
					img: "btc-x2"
				),
				diffStep: "+3.24%",
				balance: "$105,489.20",
				diff: "+$269.12",
				up: true
			),
			Favorite(
				coin: Coin(
					text: "eth",
					img: "eth-x2"
				),
				diffStep: "-0.89%",
				balance: "$2,520.44",
				diff: "-$4.42",
				up: false
			),
			Favorite(
				coin: Coin(
					text: "trx",
					img: "trx-x2"
				),
				diffStep: "+0.24%",
				balance: "$15,403.98",
				diff: "+$29.12",
				up: true
			),
			Favorite(
				coin: Coin(
					text: "dsh",
					img: "dsh-x2"
				),
				diffStep: "-0.30%",
				balance: "$5,434.98",
				diff: "-$9.12",
				up: false
			),
		]
	}
}
