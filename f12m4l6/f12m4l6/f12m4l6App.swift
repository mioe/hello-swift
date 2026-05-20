// by mioe

import SwiftUI

@main
struct f12m4l6App: App {

init() {
	// путь к SQLite
	print(URL.applicationSupportDirectory.path(percentEncoded: false))
}

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
