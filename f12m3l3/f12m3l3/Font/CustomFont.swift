// by mioe

import SwiftUI

enum fontIAWriterQuattroS: String {
	case regular = "iAWriterQuattroS-Regular"
}

enum fontLora: String {
	case medium = "Lora-Medium"
}

extension Text {
	func iAWritterQuattroS(_ font: fontIAWriterQuattroS, _ size: CGFloat) -> some View {
		self
			.font(.custom(font.rawValue, size: size))
			.tracking(-0.8)
	}
	
	func lora(_ font: fontLora, _ size: CGFloat) -> some View {
		self
			.font(.custom(font.rawValue, size: size))
	}
}
