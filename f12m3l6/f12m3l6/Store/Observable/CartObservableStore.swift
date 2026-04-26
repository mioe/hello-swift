// by mioe

import Foundation
import Observation
import SwiftData

@Observable
@MainActor
class CartObservableStore {

	var modelContext: ModelContext?

	func addYummyToCart(yummy: Yummy, yummySize: YummySize = .md, qty: Int = 1) {
		guard let context = modelContext else { return }

		// валидация размера, если при быстром добавлении товара из карточки нет нужного размера бери первый из доступных
		guard let resolvedSize = yummy.availableSizes.contains(yummySize)
			? yummySize
			: yummy.availableSizes.first
		else { return }

		print("addYummyToCart: \(yummy.name) | \(resolvedSize) | \(qty)")
	}
}
