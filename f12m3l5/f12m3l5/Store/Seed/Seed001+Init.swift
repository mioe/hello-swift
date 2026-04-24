// by mioe

import Foundation
import SwiftData

enum Seed001Init: Seedable {
	static let id = "001-init"

	// MARK: - Up
	static func up(context: ModelContext) throws {
		let foods = Category(
			name: "Foods",
			sortOrder: 0
		)
		let beverages = Category(
			name: "Beverages",
			sortOrder: 1
		)
		let desserts = Category(
			name: "Desserts",
			sortOrder: 2
		)
		
		[foods, desserts, beverages].forEach { context.insert($0) }

		let yummies: [Yummy] = [
			
		]

		yummies.forEach { context.insert($0) }
	}

	// MARK: - Down
	static func down(context: ModelContext) throws {
		// удаляем всё что вставил up() - все категории каскадно удалят yummies через .nullify
		// но yummies удаляем явно чтобы не оставлять сирот
		try context.delete(model: Yummy.self)
		try context.delete(model: Category.self)
	}
}
