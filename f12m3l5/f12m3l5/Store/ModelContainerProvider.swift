// by mioe

import Foundation
import SwiftData

// MARK: - aliases for models
typealias Category = AppSchemaV1.Category
typealias Attachment = AppSchemaV1.Attachment
typealias Yummy = AppSchemaV1.Yummy
typealias Ticket = AppSchemaV1.Ticket
typealias History = AppSchemaV1.History
typealias YummySize = AppSchemaV1.YummySize

// MARK: - init db
// > https://youtu.be/CrWqfCDmPVI?si=iMI8c60upB4ZwJJv
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
			SeedMigrationPlan.run(context: ModelContext(container))

			return container
		} catch {
			fatalError("Could not create the Model Container: \(error)")
		}
	}

	private static func setModelContainerSchema() -> Schema {
		return Schema([
			SeedMigration.self,
			Category.self,
			Attachment.self,
			Yummy.self,
			Ticket.self,
			History.self,
		])
	}

}
