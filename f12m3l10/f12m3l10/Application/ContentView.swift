// by mioe

import SwiftUI

struct ContentView: View {
	@AppStorage("f12m3l10:isShowOnboardingView")
	private var isShowOnboardingView: Bool = true

	var body: some View {
		if isShowOnboardingView == false {
			OnboardingView(onSubmit: {
				isShowOnboardingView.toggle()
			})
//			.onAppear {
//				for f in UIFont.familyNames.filter({
//					$0.hasPrefix("Poppins")
//				}) {
//					let v = UIFont.fontNames(forFamilyName: f)
//					print("\(f): \(v)")
//				}
//			}
		} else {
			PackagesView(onTapCar: {
				isShowOnboardingView.toggle()
			})
		}
	}
}
