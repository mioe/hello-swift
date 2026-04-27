// by mioe

import Foundation
import SwiftData

protocol Seedable {
	static var id: String { get }
	static func up(context: ModelContext) throws
	static func down(context: ModelContext) throws
}
