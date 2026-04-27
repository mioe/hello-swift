// by mioe

import SwiftData
import SwiftUI

struct ContentView: View {
	@State private var router = AppRouter()
	@State private var cart = CartObservableStore()

	@Environment(\.modelContext) private var modelContext

	init() {
		UITabBar.appearance().isHidden = true
	}

	var body: some View {
		ZStack(alignment: .bottom) {
			AppTabView(tabSelection: $router.currentTab)
			CustomTabBar(currentTab: $router.currentTab)
		}
		.environment(router)
		.environment(cart)
		.onAppear {
			cart.modelContext = modelContext // передаем контекс базы в стор

			// вывод списка доступных шрифтов
			for f in UIFont.familyNames.filter({
				$0.hasPrefix("iA") || $0.hasPrefix("Lora")
			}) {
				let v = UIFont.fontNames(forFamilyName: f)
				print("\(f): \(v)")
			}
		}
	}

	@ViewBuilder
	private func AppTabView(tabSelection: Binding<AppTab>) -> some View {
		TabView(selection: tabSelection) {
			NavigationStack(path: $router.homePath) {
				HomeView()
					.appRouteDestinations()
			}
			.tag(AppTab.home)
			CartView()
				.tag(AppTab.cart)
			HistoryView()
				.tag(AppTab.history)
			SettingsView()
				.tag(AppTab.settings)
		}
	}
}

// MARK: - CustomTabBar
private struct CustomTabBar: View {
	@Binding var currentTab: AppTab
	@Namespace private var dotNamespace

	@Query(sort: \History.createdAt, order: .reverse)
	private var histories: [History]

	// число позиций в активном (pending) заказе - для бейджа на иконке корзины
	private var pendingCount: Int {
		histories.first(where: { $0.status == .pending })?.tickets.count ?? 0
	}

	var body: some View {
		HStack(spacing: 0) {
			ForEach(AppTab.allCases, id: \.self) { tab in
				TabItem(
					tab: tab,
					isActive: currentTab == tab,
					badge: tab == .cart && pendingCount > 0 ? pendingCount : nil,
					dotNamespace: dotNamespace
				) {
					withAnimation {
						currentTab = tab
					}
				}
			}
		}
		.padding(.horizontal, 12)
		.frame(width: 200, height: 40)
		.background(.sAccent)
		.clipShape(Capsule())
		.shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 4)
	}
}

// MARK: - TabItem
private struct TabItem: View {
	let tab: AppTab
	let isActive: Bool
	let badge: Int?
	let dotNamespace: Namespace.ID
	let onTap: () -> Void

	var body: some View {
		Button {
			onTap()
		} label: {
			VStack(spacing: 0) {
				Image(systemName: tab.iconName)
					.font(.system(size: 18))
					.foregroundStyle(isActive ? .white : .white.opacity(0.75))
					.offset(y: 2)
					.overlay(alignment: .topTrailing) {
						if let badge {
							Text("\(badge)")
								.iAWritterQuattroS(8)
								.foregroundStyle(.sAccent)
								.frame(minWidth: 14, minHeight: 14)
								.background(.white, in: Capsule())
								.offset(x: 8, y: -4)
						}
					}

				Circle()
					.fill(isActive ? .white : .clear)
					.frame(width: 5, height: 5)
					.offset(y: 8)
					.matchedGeometryEffect(
						id: "dot",
						in: dotNamespace,
						isSource: isActive
					)
			}
			.frame(maxWidth: .infinity)
		}
		.buttonStyle(.plain)
	}
}
