// by mioe

import Foundation

struct AppStoreCollection: Identifiable {
	let id: String = UUID().uuidString
	let items: [AppStoreModel]
	
	static func mock() -> [AppStoreCollection] {
		[]
	}
}
