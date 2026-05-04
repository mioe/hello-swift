// by mioe

import SwiftUI

extension View {
	func badge(_ count: Int, bgColor: Color = .red, textColor: Color = .white) -> some View {
		overlay(alignment: .topTrailing) {
			if count > 0 {
				Text(count > 99 ? "99+" : "\(count)")
					.font(.system(size: 11, weight: .semibold))
					.foregroundStyle(textColor)
					.padding(.horizontal, 5)
					.padding(.vertical, 2)
					.background(bgColor, in: .capsule)
					.offset(x: 5, y: -5)
			}
		}
	}
}
