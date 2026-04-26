// by mioe

import SwiftUI

struct HistoryView: View {
		
	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 32) {
				CustomNavigationView(title: "History")
				Text("History")
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
