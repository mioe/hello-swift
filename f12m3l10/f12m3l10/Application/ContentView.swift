// by mioe

import SwiftUI

struct ContentView: View {
	@AppStorage("f12m3l10:isShowOnboardingView")
	private var isShowOnboardingView: Bool = true

	var body: some View {
		if isShowOnboardingView == true {
			OnboardingView(onSubmit: {
				isShowOnboardingView.toggle()
			})
		} else {
			PackagesView()
		}
	}
}
