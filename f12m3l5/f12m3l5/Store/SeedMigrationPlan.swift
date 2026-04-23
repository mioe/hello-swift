// by mioe

import Foundation
import SwiftData

protocol SeedMigration {
	static var id: String { get }  // 001-init
	static func up(context: ModelContext) throws
	static func down(context: ModelContext) throws
}

enum SeedMigrationPlan {
	// MARK: - Registry - добавляй новые сиды сюда по порядку
	static let migrations: [any SeedMigration.Type] = [
		Seed001Init.self
	]

	// MARK: - Run
	static func run(context: ModelContext) {
		for migration in migrations {
			guard !isApplied(migration.id) else { continue }
			do {
				try migration.up(context: context)
				try context.save()
				markApplied(migration.id)
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
			try context.save()
			markUnapplied(id)
			print("[Seed] rolled back: \(id)")
		} catch {
			print("[Seed] rollback failed: \(id) — \(error)")
		}
	}

	// MARK: - State (UserDefaults)
	private static let defaultsKey = "appliedSeedMigrations"

	static func isApplied(_ id: String) -> Bool {
		applied.contains(id)
	}

	private static var applied: [String] {
		UserDefaults.standard.stringArray(forKey: defaultsKey) ?? []
	}

	private static func markApplied(_ id: String) {
		var list = applied
		list.append(id)
		UserDefaults.standard.set(list, forKey: defaultsKey)
	}

	private static func markUnapplied(_ id: String) {
		let list = applied.filter { $0 != id }
		UserDefaults.standard.set(list, forKey: defaultsKey)
	}
}
