// by mioe

import SwiftUI

struct SectionTitleView: View {

	let title: String

	var body: some View {
		Text(title)
			.font(.system(size: 20, weight: .semibold))
	}
}
