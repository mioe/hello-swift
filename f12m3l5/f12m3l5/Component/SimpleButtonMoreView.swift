// by mioe

import SwiftUI

struct SimpleButtonMoreView: View {
	
	let onTap: () -> Void
	
	var body: some View {
		Button {
			onTap()
		} label: {
			Text("More")
				.iAWritterQuattroS(14)
				.foregroundStyle(.sAccent)
		}
		.buttonStyle(.plain)
	}
}
