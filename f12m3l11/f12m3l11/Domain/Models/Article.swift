// by mioe

import Foundation

struct Article: Hashable {
	let id: String = UUID().uuidString
	let text: String
	let img: String
	
	static func mock() -> [Article] {
		return mockBase()
	}
	
	private static func mockBase() -> [Article] {
		[
			Article(
				text: "How to earn with Finity",
				img: "img-1-x2",
			),
			Article(
				text: "Complete anonymity",
				img: "img-2-x2",
			),
			Article(
				text: "How to save crypto",
				img: "img-3-x2",
			),
			Article(
				text: "Ideas for realization",
				img: "img-4-x2",
			),
			Article(
				text: "Best crypto coins",
				img: "img-5-x2",
			),
		]
	}
}
