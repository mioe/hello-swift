// by mioe

import Foundation
import SwiftData

@Model
final class SeedMigration {
	@Attribute(.unique) var seedId: String
	var appliedAt: Date

	init(seedId: String) {
		self.seedId = seedId
		self.appliedAt = .now
	}
}
