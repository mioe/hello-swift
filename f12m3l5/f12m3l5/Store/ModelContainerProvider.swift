// by mioe

import Foundation
import SwiftData

// MARK: - aliases for models
typealias Category = AppSchemaV1.Category
typealias Yummy = AppSchemaV1.Yummy
typealias Ticket = AppSchemaV1.Ticket
typealias History = AppSchemaV1.History

// MARK: - init db
class ModelContainerProvider {
	static func createModelContainer() -> ModelContainer {
		let schema = setModelContainerSchema()
		let modelConfiguration = ModelConfiguration(
			"f12m3l5-db",
			schema: schema,
			isStoredInMemoryOnly: false
		)

		do {
			let container = try ModelContainer(
				for: schema,
				migrationPlan: ModelMigrationPlan.self,
				configurations: [modelConfiguration]
			)
			return container
		} catch {
			fatalError("Could not create the Model Container: \(error)")
		}
	}

	private static func setModelContainerSchema() -> Schema {
		return Schema([
			Category.self,
			Yummy.self,
			Ticket.self,
			History.self,
		])
	}
}
