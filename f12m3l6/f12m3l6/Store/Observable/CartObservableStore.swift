// by mioe

import Foundation
import Observation
import SwiftData

@Observable
@MainActor
class CartObservableStore {

	var modelContext: ModelContext?

	func addYummyToCart(yummy: Yummy, yummySize: YummySize = .md, qty: Int = 1) {
		guard let context = modelContext else { return }

		// валидация размера, если при быстром добавлении товара из карточки нет нужного размера бери первый из доступных
		guard let resolvedSize = yummy.availableSizes.contains(yummySize)
			? yummySize
			: yummy.availableSizes.first
		else { return }
		
		print("addYummyToCart: \(yummy.name) | \(resolvedSize) | \(qty)")

		let ticket = Ticket(yummy: yummy, quantity: qty, size: resolvedSize)
		context.insert(ticket)

		let descriptor = FetchDescriptor<History>(
			sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
		)
		let histories = (try? context.fetch(descriptor)) ?? []

		if let pending = histories.first(where: { $0.status == .pending }) {
			ticket.history = pending
			pending.totalPrice += ticket.subtotal
		} else {
			context.insert(History(tickets: [ticket]))
		}

		try? context.save()
	}
	
	func removeTicket(ticket: Ticket) {
		guard let context = modelContext else { return }

		// захватываем до удаления: после context.delete доступ к ticket-у уже невалиден
		let pending = ticket.history
		let subtotal = ticket.subtotal
		let wasLast = (pending?.tickets.count ?? 0) <= 1

		context.delete(ticket)

		if let pending {
			if wasLast {
				// последний тикет в заказе - сносим саму History, чтобы не висел пустой pending
				context.delete(pending)
			} else {
				pending.totalPrice -= subtotal
			}
		}

		try? context.save()
	}
	
	func closePendingCart(_ history: History) {
		guard let context = modelContext else { return }
		
		history.status = .completed
		try? context.save()
	}
}
