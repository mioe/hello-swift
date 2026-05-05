// by mioe

import SwiftUI

@main
struct f12m3l11App: App {
	@State private var theme = ThemeStore()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(theme)
				.tint(theme.accent)
				.preferredColorScheme(theme.colorScheme)
		}
	}
}
