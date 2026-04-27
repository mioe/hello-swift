// by mioe

import Foundation
import SwiftData

// MARK: - SeedMigrationPlan
enum SeedMigrationPlan {
	static let migrations: [any Seedable.Type] = [
		Seed001Init.self,
		Seed002Done.self,
	]

	// MARK: - Run
	static func run(context: ModelContext) {
		for migration in migrations {
			guard !isApplied(migration.id, context: context) else { continue }
			do {
				try migration.up(context: context)
				context.insert(SeedMigration(seedId: migration.id))
				try context.save()
				print("[Seed] applied: \(migration.id)")
			} catch {
				print("[Seed] failed: \(migration.id) — \(error)")
			}
		}
	}

	// MARK: - Rollback
	static func rollback(_ id: String, context: ModelContext) {
		guard let migration = migrations.first(where: { $0.id == id }) else {
			print("[Seed] rollback: '\(id)' not found")
			return
		}
		do {
			try migration.down(context: context)
			try deleteSeedRecord(id, context: context)
			try context.save()
			print("[Seed] rolled back: \(id)")
		} catch {
			print("[Seed] rollback failed: \(id) — \(error)")
		}
	}

	// MARK: - State (SwiftData)
	static func isApplied(_ id: String, context: ModelContext) -> Bool {
		let predicate = #Predicate<SeedMigration> { $0.seedId == id }
		let count = try? context.fetchCount(FetchDescriptor(predicate: predicate))
		return (count ?? 0) > 0
	}

	private static func deleteSeedRecord(_ id: String, context: ModelContext) throws {
		let predicate = #Predicate<SeedMigration> { $0.seedId == id }
		let records = try context.fetch(FetchDescriptor(predicate: predicate))
		records.forEach { context.delete($0) }
	}
}
