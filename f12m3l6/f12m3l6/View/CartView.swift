// by mioe

import SwiftUI

struct CartView: View {

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 32) {
				CustomNavigationView(title: "Cart")
				Text("Cart")
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.horizontal, 32)
		.padding(.top, 20)
		.padding(.bottom, 64)
	}
}
