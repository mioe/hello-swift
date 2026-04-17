// by mioe

import Foundation

struct AppStoreModel: Identifiable {
	let id: String = UUID().uuidString
	let icon: String
	let shortName: String
	let fullName: String
	let description: String
	var preview: String? = nil
}
