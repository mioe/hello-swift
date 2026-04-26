// by mioe

import SwiftData
import SwiftUI

@main
struct f12m3l5App: App {
	var sharedModelContainer: ModelContainer =
		ModelContainerProvider.createModelContainer()

	init() {
		// путь к базеданных
		print(URL.applicationSupportDirectory.path(percentEncoded: false))
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		.modelContainer(sharedModelContainer)
	}
}
