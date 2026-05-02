// by mioe

import SwiftUI

struct CustomShape: Shape {
	var flipped: Bool = false

	func path(in rect: CGRect) -> Path {
		var path = Path()

		// Исходный viewBox: 430 × 200
		let sx = rect.width / 430
		let sy = rect.height / 200

		func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
			CGPoint(x: rect.minX + x * sx, y: rect.minY + y * sy)
		}

		path.move(to: p(379.346903, 0))
		path.addLine(to: p(381.186621, 0.0125335404))
		path.addLine(to: p(382.444277, 0.0294983563))
		path.addCurve(
			to: p(409.536914, 5.34265408),
			control1: p(397.495453, 0.279278685),
			control2: p(403.493494, 2.11059786)
		)
		path.addCurve(
			to: p(424.657346, 20.4630859),
			control1: p(416.055433, 8.82879593),
			control2: p(421.171204, 13.9445674)
		)
		path.addLine(to: p(425.020367, 21.1535867))
		path.addLine(to: p(425.371148, 21.8467047))
		path.addCurve(
			to: p(430, 51.277704),
			control1: p(428.396333, 27.9510393),
			control2: p(430, 34.7059439)
		)
		path.addLine(to: p(430, 148.722296))
		path.addCurve(
			to: p(424.657346, 179.536914),
			control1: p(430, 166.552671),
			control2: p(428.143488, 173.018396)
		)
		path.addCurve(
			to: p(409.536914, 194.657346),
			control1: p(421.171204, 186.055433),
			control2: p(416.055433, 191.171204)
		)
		path.addLine(to: p(408.846413, 195.020367))
		path.addLine(to: p(408.153295, 195.371148))
		path.addCurve(
			to: p(378.722296, 200.000287),
			control1: p(402.048961, 198.396333),
			control2: p(395.294056, 200.000287)
		)
		path.addLine(to: p(289.260987, 200.000287))
		path.addCurve(
			to: p(270.148044, 185.882842),
			control1: p(280.482093, 199.999243),
			control2: p(272.73016, 194.273412)
		)
		path.addCurve(
			to: p(215, 148.722296),
			control1: p(262.526871, 161.109195),
			control2: p(244.144355, 148.722296)
		)
		path.addCurve(
			to: p(159.852451, 185.882994),
			control1: p(185.855645, 148.722296),
			control2: p(167.473129, 161.109195)
		)
		path.addLine(to: p(159.851956, 185.882842))
		path.addCurve(
			to: p(140.739013, 200.000287),
			control1: p(157.26984, 194.273412),
			control2: p(149.517907, 199.999243)
		)
		path.addLine(to: p(51.277704, 200.000287))
		path.addCurve(
			to: p(20.4630859, 194.657346),
			control1: p(33.4473292, 200.000287),
			control2: p(26.9816044, 198.143488)
		)
		path.addCurve(
			to: p(5.34265408, 179.536914),
			control1: p(13.9445674, 191.171204),
			control2: p(8.82879593, 186.055433)
		)
		path.addLine(to: p(4.97533387, 178.838084))
		path.addLine(to: p(4.73443918, 178.364955))
		path.addCurve(
			to: p(0, 149.346903),
			control1: p(1.67970387, 172.281068),
			control2: p(0.0412768744, 165.653861)
		)
		path.addLine(to: p(0, 51.277704))
		path.addCurve(
			to: p(5.34265408, 20.4630859),
			control1: p(0, 33.4473292),
			control2: p(1.85651222, 26.9816044)
		)
		path.addCurve(
			to: p(20.4630859, 5.34265408),
			control1: p(8.82879593, 13.9445674),
			control2: p(13.9445674, 8.82879593)
		)
		path.addLine(to: p(21.1619159, 4.97533387))
		path.addLine(to: p(21.6350454, 4.73443918))
		path.addCurve(
			to: p(50.6530969, 0),
			control1: p(27.7189318, 1.67970387),
			control2: p(34.3461389, 0.0412768744)
		)
		path.addLine(to: p(116.019648, 0.00885958338))
		path.addCurve(
			to: p(143.122697, 26.670938),
			control1: p(130.841137, 0.0108684428),
			control2: p(142.883336, 11.9064847)
		)
		path.addLine(to: p(143.126329, 27.1192145))
		path.addCurve(
			to: p(157.079042, 54.1916113),
			control1: p(143.248356, 41.3871388),
			control2: p(151.433863, 51.2472077)
		)
		path.addCurve(
			to: p(185.53775, 57.1178906),
			control1: p(162.724221, 57.1360149),
			control2: p(170.358168, 57.0767281)
		)
		path.addLine(to: p(251.695735, 57.1180464))
		path.addCurve(
			to: p(271.583223, 54.1916113),
			control1: p(262.028897, 57.0836036),
			control2: p(266.790203, 56.7549465)
		)
		path.addLine(to: p(271.996674, 53.9635891))
		path.addCurve(
			to: p(285.996187, 27.6461302),
			control1: p(277.771546, 50.6829128),
			control2: p(285.767831, 42.1521065)
		)
		path.addLine(to: p(286.00104, 27.1192145))
		path.addCurve(
			to: p(313.120255, 0),
			control1: p(286.00104, 12.1416859),
			control2: p(298.142726, 0)
		)
		path.closeSubpath()

		if flipped {
			path = path.applying(
				CGAffineTransform(scaleX: 1, y: -1)
					.translatedBy(x: 0, y: -rect.height)
			)
		}

		return path
	}
}
