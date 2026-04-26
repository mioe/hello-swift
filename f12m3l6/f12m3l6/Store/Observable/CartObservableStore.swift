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
		
		print("addYummyToCart: \(yummy.name) | \(yummySize) | \(qty)")
	}
}
