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
