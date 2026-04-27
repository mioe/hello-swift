// by mioe

import SwiftData
import SwiftUI

struct HistoryView: View {

	// SwiftData #Predicate не умеет в Codable enum, фильтруем completed в памяти
	@Query(sort: \History.orderedAt, order: .reverse)
	private var histories: [History]

	private var completedOrders: [History] {
		histories.filter { $0.status == .completed }
	}

	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 32) {
				CustomNavigationView(title: "History")

				if completedOrders.isEmpty {
					Text("Empty...")
						.iAWritterQuattroS(14)
						.foregroundStyle(.sPrimary)
				} else {
					ForEach(completedOrders, id: \.id) { order in
						OrderSectionView(order)
					}
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
	private func PriceView(_ cost: Decimal, size: CGFloat = 10) -> some View {
		HStack(spacing: 2) {
			Text("$")
				.iAWritterQuattroS(size)
			Text(
				cost,
				format: .number.precision(.fractionLength(0...2)).locale(
					Locale(identifier: "en_US")
				)
			)
			.iAWritterQuattroS(size)
		}
		.foregroundStyle(.sPrimary)
	}

	@ViewBuilder
	private func OrderSectionView(_ order: History) -> some View {
		VStack(alignment: .leading, spacing: 12) {
			HStack {
				Text(
					order.orderedAt,
					format: .dateTime.day().month(.abbreviated).year().hour().minute()
				)
				.lora(14)
				.foregroundStyle(.sPrimary.opacity(0.5))
				Spacer()
				PriceView(order.totalPrice, size: 14)
			}

			VStack(alignment: .leading, spacing: 8) {
				ForEach(order.tickets, id: \.id) { ticket in
					TicketRowView(ticket)
				}
			}
		}
	}

	@ViewBuilder
	private func TicketRowView(_ ticket: Ticket) -> some View {
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
			VStack(alignment: .trailing) {
				HStack(spacing: 4) {
					Text("x")
						.iAWritterQuattroS(12)
					Text("\(ticket.quantity)")
						.iAWritterQuattroS(14)
				}
				.foregroundStyle(.sPrimary.opacity(0.5))
				PriceView(ticket.subtotal)
			}
		}
		.foregroundStyle(.sPrimary)
	}
}
