// by mioe

import SwiftUI

struct CropperIconPlayView: View {
	enum Size {
		case sm, md
		
		var diameter: CGFloat {
			switch self {
			case .sm: 18
			case .md: 30
			}
		}
		
		var iconSize: CGFloat {
			switch self {
			case .sm: 8
			case .md: 14
			}
		}
		
		var patchPaddingIcon: CGFloat {
			switch self {
			case .sm: 1
			case .md: 2
			}
		}
	}
	
	var size: Size = .sm
	
	var body: some View {
		Circle()
			.fill(.white)
			.overlay {
				Image(systemName: "play.fill")
					.font(.system(size: size.iconSize, weight: .medium))
					.blendMode(.destinationOut) // вычитает себя из круга
					.padding(.leading, size.patchPaddingIcon)
			}
			.compositingGroup() // ВАЖНО: изолирует рендер, иначе сотрёт и фон
			.frame(width: size.diameter, height: size.diameter)
	}
}
