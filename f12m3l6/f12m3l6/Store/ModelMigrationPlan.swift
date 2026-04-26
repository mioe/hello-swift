// by mioe

import Foundation
import SwiftData

enum ModelMigrationPlan: SchemaMigrationPlan {
	static var schemas: [any VersionedSchema.Type] {
		[AppSchemaV1.self]
	}

	static var stages: [MigrationStage] {
		[]
		//		[migrateV1toV2]
	}

	//	static let migrateV1toV2 = MigrationStage.lightweight(
	//		fromVersion: AppSchemaV1.self,
	//		toVersion: AppSchemaV2.self
	//	)
}
