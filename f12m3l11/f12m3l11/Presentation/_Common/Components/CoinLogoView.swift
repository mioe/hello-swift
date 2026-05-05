// by mioe

import SwiftUI

struct CoinLogoView: View {

	enum Size: String {
		case sm, md
	}

	let img: String
	var size: Size = .sm

	private var iconSize: CGFloat {
		size == .sm ? 28 : 36
	}

	var body: some View {
		Image(img)
			.resizable()
			.frame(width: iconSize, height: iconSize)
	}
}
