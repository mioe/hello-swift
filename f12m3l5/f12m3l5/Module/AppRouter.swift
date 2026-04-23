// by mioe

import SwiftData
import SwiftUI

// MARK: - AppTab
enum AppTab: Hashable, CaseIterable {
	case home
	case cart
	case history
	case settings

	var iconName: String {
		switch self {
		case .home: "house"
		case .cart: "bag"
		case .history: "receipt"
		case .settings: "gearshape"
		}
	}
}

// MARK: - AppRoute
enum AppRoute: Hashable {
	case yummyDetail(UUID)  // /yummy/{uuid}
}

// MARK: - AppRouter
@Observable
@MainActor
class AppRouter {
	var currentTab: AppTab = .home
	var homePath = NavigationPath()  // только home имеет дочерние страницы

	// /yummy/{uuid} — всегда открывается на home табе
	func openYummyDetail(_ id: UUID) {
		currentTab = .home
		homePath.append(AppRoute.yummyDetail(id))
	}

	func pop() {
		if !homePath.isEmpty { homePath.removeLast() }
	}

	func popToRoot() {
		homePath = NavigationPath()
	}
}
