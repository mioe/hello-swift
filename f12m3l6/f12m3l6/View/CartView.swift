// by mioe

import SwiftData
import SwiftUI

struct CartView: View {
	
	@Query
	private var histories: [History]


	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 32) {
				CustomNavigationView(title: "Cart")

				if let order = histories.first {
					ForEach(order.tickets, id: \.id) { ticket in
						Text("\(ticket.nameSnapshot)")
					}
				} else {
					Text("Empty...")
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
}
