// by mioe

import Foundation
import SwiftData

enum Seed002Promotions: Seedable {
	static let id = "002-promotions"

	// MARK: - Up
	static func up(context: ModelContext) throws {
		let desserts = Category(
			name: "Desserts",
			iconName: "birthday.cake.fill",
			sortOrder: 2
		)
		context.insert(desserts)

		let yummies: [Yummy] = [
			Yummy(
				name: "Matcha Cream Latte",
				info: "Premium matcha blended with steamed milk and vanilla cream",
				image: "matcha-latte-img",
				category: desserts,
				basePrice: 7.5,
				originalPrice: 10.0,
				availableSizes: [.sm, .md, .lr],
				rating: 4.8,
				isPromoted: true
			),
			Yummy(
				name: "Caramel Waffle Cake",
				info: "Crispy waffle layers with salted caramel and whipped cream",
				image: "caramel-waffle-img",
				category: desserts,
				basePrice: 5.9,
				originalPrice: 8.5,
				availableSizes: [.sm, .md],
				rating: 4.6,
				isPromoted: true
			),
			Yummy(
				name: "Strawberry Cheesecake",
				info: "Classic New York cheesecake with fresh strawberry compote",
				image: "strawberry-cheesecake-img",
				category: desserts,
				basePrice: 6.3,
				availableSizes: [.sm, .md, .lr],
				rating: 4.4,
				isPromoted: true
			),
		]

		yummies.forEach { context.insert($0) }
	}

	// MARK: - Down
	static func down(context: ModelContext) throws {
		let predicate = #Predicate<Category> { $0.name == "Desserts" }
		let categories = try context.fetch(FetchDescriptor(predicate: predicate))
		categories.forEach { context.delete($0) }
	}
}
