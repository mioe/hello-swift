// by mioe

import Foundation
import SwiftData

enum Seed003Fix: Seedable {
	static let id = "003-fix"

	// MARK: - Up
	static func up(context: ModelContext) throws {
		let changelog = Changelog(
			title: "badge",
			info: "Добавил badge для корзины.",
			type: .fix,
			isViewed: false,
			createdAt: Date(timeIntervalSince1970: 1_777_292_120)
		)
		context.insert(changelog)
	}

	// MARK: - Down
	static func down(context: ModelContext) throws {
		try context.delete(model: Changelog.self)
	}
}
