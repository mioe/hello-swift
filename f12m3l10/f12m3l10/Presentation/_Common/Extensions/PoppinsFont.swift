// by mioe

import SwiftUI

enum PoppinsWeight: String {
	case regular = "Poppins-Regular"
	case medium = "Poppins-Medium"
	case semiBold = "Poppins-SemiBold"
}

extension Text {
	func poppins(_ size: CGFloat, _ weight: PoppinsWeight = .regular) -> some View
	{
		self.font(.custom(weight.rawValue, size: size))
	}
}
