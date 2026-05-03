// by mioe

import SwiftUI

struct OnboardingView: View {
	
	let onSubmit: () -> Void
	
	var body: some View {
		Text("OnboardingView")
		
		Button {
			onSubmit()
		} label: {
			Text("Submit")
		}
	}
}
