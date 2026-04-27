// by mioe

import Foundation
import SwiftData

enum Seed002Done: Seedable {
	static let id = "002-done"

	// MARK: - Up
	static func up(context: ModelContext) throws {
		let changelog = Changelog(
			title: "f12m3l6",
			info: """
				По домашке реализовано: CategoryView, CartView, HistoryView на SwiftData.

				Корзина собирает Ticket'ы в одну активную History (`.pending`) через `addYummyToCart`, `removeTicket` удаляет позицию и сносит пустой заказ, `closePendingCart` переводит заказ в `.completed`. HistoryView отображает завершённые заказы с датой, позициями и итогом, сортировка по `orderedAt`.

				Статус заказа вынесен в отдельный enum `HistoryOrderStatus`. Фильтр pending/completed делается в памяти — `#Predicate` в SwiftData не поддерживает захват Codable-енама как параметра запроса.
				""",
			type: .feat,
			isViewed: false,
			createdAt: Date(timeIntervalSince1970: 1_777_500_000)
		)
		context.insert(changelog)
	}

	// MARK: - Down
	static func down(context: ModelContext) throws {
		try context.delete(model: Changelog.self)
	}
}
