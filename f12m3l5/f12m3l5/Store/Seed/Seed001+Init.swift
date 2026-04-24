// by mioe

import Foundation
import SwiftData

enum Seed001Init: Seedable {
	static let id = "001-init"

	// MARK: - Up
	static func up(context: ModelContext) throws {
		let beverages = Category(
			name: "Beverages",
			iconName: "cup.and.saucer",
			sortOrder: 0
		)
		let foods = Category(
			name: "Foods",
			iconName: "fork.knife",
			sortOrder: 1
		)

		[beverages, foods].forEach { context.insert($0) }

		let yummies: [Yummy] = [
			// Promotion
			Yummy(
				name: "Hot Mocha Cappuccino Latte",
				info: "Espresso with steamed milk, mocha sauce and chocolate foam",
				image: "mocha-cappuccino-img",
				category: beverages,
				basePrice: 6.7,
				originalPrice: 9.5,
				availableSizes: [.sm, .md, .lr],
				rating: 4.5,
				isPromoted: true
			),
			// Beverages
			Yummy(
				name: "Hot Sweet Indonesian Tea",
				info: "Rich black tea with palm sugar and spices",
				image: "indonesian-tea-img",
				category: beverages,
				basePrice: 8.2,
				availableSizes: [.sm, .md, .lr, .xl],
				rating: 4.0,
				isFeatured: true
			),
			Yummy(
				name: "Original Coffee Latte",
				info: "Smooth espresso blended with fresh steamed milk",
				image: "coffee-latte-img",
				category: beverages,
				basePrice: 12.6,
				availableSizes: [.sm, .md, .lr, .xl],
				rating: 3.0,
				isFeatured: true
			),
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
