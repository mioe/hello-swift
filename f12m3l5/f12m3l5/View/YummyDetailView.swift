// by mioe

import SwiftUI

struct YummyDetailView: View {
	
	var yummy: Yummy
	
	var body: some View {
		Text("\(yummy.name)")
	}
}
