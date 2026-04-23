// by mioe

import SwiftUI

struct ContentView: View {
	@State private var router = AppRouter()

	init() {
		UITabBar.appearance().isHidden = true
	}

	var body: some View {
		ZStack(alignment: .bottom) {
			AppTabView(tabSelection: $router.currentTab)
			CustomTabBar(currentTab: $router.currentTab)
		}
		.environment(router)
		.onAppear {
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

	var body: some View {
		HStack(spacing: 0) {
			ForEach(AppTab.allCases, id: \.self) { tab in
				TabItem(
					tab: tab,
					isActive: currentTab == tab,
					dotNamespace: dotNamespace
				) {
					withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
						currentTab = tab
					}
				}
			}
		}
		.padding(.horizontal, 12)
		.frame(width: 200, height: 40)
		.background(.red)
		.clipShape(Capsule())
		.shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 4)
	}
}

// MARK: - TabItem
private struct TabItem: View {
	let tab: AppTab
	let isActive: Bool
	let dotNamespace: Namespace.ID
	let onTap: () -> Void

	var body: some View {
		Button {
			onTap()
		} label: {
			VStack(spacing: 0) {
				Image(systemName: tab.iconName)
					.font(.system(size: 18))
					.foregroundStyle(isActive ? .primary : .secondary)
					.offset(y: 2)

				Circle()
					.fill(isActive ? Color.primary : Color.clear)
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
