// by mioe

import Foundation

struct UserModel {
	let id: String = UUID().uuidString
	let username: String
	let nickname: String
	let avatar: String?
}
