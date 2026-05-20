// by mioe

import SwiftUI

@main
struct f12m4l7App: App {

	init() {
		print(URL.applicationSupportDirectory.path(percentEncoded: false))
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
