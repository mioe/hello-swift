// by mioe

import SwiftUI

struct SettingsView: View {
	
	var body: some View {
		ScrollView {
			CustomNavigationView(title: "Settings")
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.horizontal, 32)
		.padding(.top, 24)
		.padding(.bottom, 64)
	}
}
