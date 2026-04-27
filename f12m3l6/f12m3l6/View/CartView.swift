// by mioe

import SwiftData
import SwiftUI

struct CartView: View {

	@Environment(AppRouter.self) private var router
	@Environment(CartObservableStore.self) private var cart

	// SwiftData #Predicate не умеет в Codable enum (Captured/constant values of type 'HistoryOrderStatus' are not supported), фильтруем pending в памяти
	@Query(sort: \History.createdAt, order: .reverse)
	private var histories: [History]

	private var activeOrder: History? {
		histories.first(where: { $0.status == .pending })
	}

	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 8) {
				CustomNavigationView(title: "Cart")
					.padding(.bottom, 24)

				if let order = activeOrder {
					ForEach(order.tickets, id: \.id) { ticket in
						OrderView(ticket)
					}

					AccentOrderButton(
						label: "Le fin",
						totalPrice: order.totalPrice,
						onTap: { handleSubmit(order) }
					)
					.padding(.top, 24)
				} else {
					Text("Empty...")
						.iAWritterQuattroS(14)
						.foregroundStyle(.sPrimary)
				}
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.contentMargins(.bottom, 120, for: .scrollContent)
		.padding(.horizontal, 32)
		.padding(.top, 20)
		.padding(.bottom, 64)
	}

	@ViewBuilder
	private func PriceView(_ cost: Decimal) -> some View {
		HStack(spacing: 2) {
			Text("$")
				.iAWritterQuattroS(10)
			Text(
				cost,
				format: .number.precision(.fractionLength(0...2)).locale(
					Locale(identifier: "en_US")
				)
			)
			.iAWritterQuattroS(10)
		}
		.foregroundStyle(.sPrimary)
	}

	@ViewBuilder
	private func OrderView(_ ticket: Ticket) -> some View {
		HStack {
			HStack {
				Text("\(ticket.nameSnapshot)")
					.lora(16)
				Text("|")
					.lora(12)
					.foregroundStyle(.sPrimary.opacity(0.5))
				Text("\(ticket.size.shortLabel)")
					.lora(16)
					.foregroundStyle(.sPrimary.opacity(0.5))
			}
			Spacer()
			HStack(spacing: 16) {
				VStack(alignment: .trailing) {
					HStack(spacing: 4) {
						Text("x")
							.iAWritterQuattroS(12)
						Text("\(ticket.quantity)")
							.iAWritterQuattroS(14)
					}
					.foregroundStyle(.sPrimary.opacity(0.5))
					HStack {
						PriceView(ticket.subtotal)
					}
				}

				Button {
					withAnimation {
						cart.removeTicket(ticket: ticket)
					}
				} label: {
					Image(systemName: "trash")
						.font(.system(size: 14))
				}
				.buttonStyle(.plain)
			}
		}
		.foregroundStyle(.sPrimary)
	}

	private func handleSubmit(_ history: History) {
		cart.closePendingCart(history)
		router.currentTab = .history
	}
}
