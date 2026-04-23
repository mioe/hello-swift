// by mioe

import SwiftData
import SwiftUI

// MARK: - AppTab
enum AppTab: Hashable {
	case home
	case cart
	case history
	case settings
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

	var homePath = NavigationPath()
	var cartPath = NavigationPath()
	var historyPath = NavigationPath()

	func push(_ route: AppRoute) {
		switch currentTab {
		case .home: homePath.append(route)
		case .cart: cartPath.append(route)
		case .history: historyPath.append(route)
		case .settings: break
		}
	}

	func pop() {
		switch currentTab {
		case .home: if !homePath.isEmpty { homePath.removeLast() }
		case .cart: if !cartPath.isEmpty { cartPath.removeLast() }
		case .history: if !historyPath.isEmpty { historyPath.removeLast() }
		case .settings: break
		}
	}

	func popToRoot() {
		switch currentTab {
		case .home: homePath = NavigationPath()
		case .cart: cartPath = NavigationPath()
		case .history: historyPath = NavigationPath()
		case .settings: break
		}
	}
}
