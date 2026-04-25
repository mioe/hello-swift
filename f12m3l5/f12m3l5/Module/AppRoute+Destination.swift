// by mioe

import SwiftData
import SwiftUI

struct AppRouteDestinations: ViewModifier {
	func body(content: Content) -> some View {
		content
			.navigationDestination(for: AppRoute.self) { route in
				switch route {
				case .yummyDetail(let id):
					YummyDetailDestination(id: id)  // /yummy/{uuid}
				case .category(let id):
					CategoryDestination(id: id)  // /category/{uuid}
				case .favorited:
					FavoritedView()  // /favorited
				case .promotion:
					PromotionView()  // /promotion
				}
			}
	}
}

extension View {
	func appRouteDestinations() -> some View {
		modifier(AppRouteDestinations())
	}
}

// MARK: - Destinations

private struct YummyDetailDestination: View {
	let id: UUID

	@Query private var results: [Yummy]

	init(id: UUID) {
		self.id = id
		_results = Query(filter: #Predicate<Yummy> { $0.id == id })
	}

	var body: some View {
		if let yummy = results.first {
			YummyDetailView(yummy: yummy)
		} else {
			ContentUnavailableView(
				"404, вкусняшка не найдена",
				systemImage: "exclamationmark.triangle"
			)
		}
	}
}

private struct CategoryDestination: View {
	let id: UUID

	@Query private var results: [Category]

	init(id: UUID) {
		self.id = id
		_results = Query(filter: #Predicate<Category> { $0.id == id })
	}

	var body: some View {
		if let category = results.first {
			CategoryView(category: category)
		} else {
			ContentUnavailableView(
				"404, категория не найдена",
				systemImage: "exclamationmark.triangle"
			)
		}
	}
}
