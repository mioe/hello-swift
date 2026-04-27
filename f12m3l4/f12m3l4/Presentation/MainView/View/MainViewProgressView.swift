// by mioe

import SwiftUI

struct MainViewProgressView: View {
	@Binding var label: String
	
	var body: some View {
		VStack {
			Text(label)
				.font(.system(size: 14))
			ProgressView()
		}
		.foregroundStyle(.secondary)
		.frame(maxWidth: .infinity)
		.padding(.vertical)
	}
}
