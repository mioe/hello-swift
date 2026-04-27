// by mioe
// > https://github.com/mioe/hello-swift/tree/main/f12m2l9

import Foundation

struct UserModel: Hashable {
	let id: String = UUID().uuidString
	let username: String
	let nickname: String
	let avatar: String?
}
