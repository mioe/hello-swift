// by mioe

import SwiftUI

struct MainViewProgressView: View {
	@Binding var label: String
	
	var body: some View {
		VStack {
			Text(label)
			ProgressView()
		}
		.foregroundStyle(.secondary)
		.frame(maxWidth: .infinity)
		.padding(.vertical)
	}
}
