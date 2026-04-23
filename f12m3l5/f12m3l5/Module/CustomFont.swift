// by mioe

import SwiftUI

enum fontIAWriterQuattroS: String {
	case regular = "iAWriterQuattroS-Regular"
}

enum fontLora: String {
	case medium = "Lora-Medium"
}

extension Text {
	func iAWritterQuattroS(_ size: CGFloat)
		-> some View
	{
		self
			.font(.custom(fontIAWriterQuattroS.regular.rawValue, size: size))
			.tracking(-0.8)
	}

	func lora(_ size: CGFloat) -> some View {
		self
			.font(.custom(fontLora.medium.rawValue, size: size))
	}
}
