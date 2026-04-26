// by mioe

import SwiftUI

struct SectionTitleView: View {
	
	let title: String
	
	var body: some View {
		Text(title)
			.lora(18)
			.foregroundStyle(.sPrimary)
	}
}
