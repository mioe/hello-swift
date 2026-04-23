// by mioe

import SwiftUI

struct ContentView: View {
	@State private var router = AppRouter()
	
	init() {
		UITabBar.appearance().isHidden = true
	}
	
	var body: some View {
		AppTabView(tabSelection: $router.currentTab)
	}
	
	@ViewBuilder
	private func AppTabView(tabSelection: Binding<AppTab>) -> some View {
		TabView(selection: tabSelection) {
		}
	}
}
