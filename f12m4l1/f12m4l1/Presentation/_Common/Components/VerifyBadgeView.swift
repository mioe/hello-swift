// by mioe

import SwiftUI

struct VerifyBadgeView: View {
	var body: some View {
		ZStack {
			Image(systemName: "seal.fill")
				.foregroundStyle(.blue)
			
			Image(systemName: "checkmark")
				.font(.system(size: 6, weight: .semibold))
				.blendMode(.destinationOut)
		}
		.compositingGroup()
		.font(.system(size: 12))
	}
}
