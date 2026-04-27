// by mioe

import Foundation

// MARK: - YummySize (размер порции)
/// protocol conformance synthesis - ближайший аналог в Rust это derive-макросы
/// js аналоги:
/// String == string union
/// Codable == JSON.stringify
/// CaseIterable == Object.values(E)
/// output -> YummySize[sm] = { priceMultiplier, shortLabel }
enum YummySize: String, Codable, CaseIterable {
	case sm, md, lr, xl

	var priceMultiplier: Decimal {  // умножаем стоимость при выборе размера
		switch self {
		case .sm: 1.0
		case .md: 1.2
		case .lr: 1.5
		case .xl: 1.8
		}
	}

	var shortLabel: String { rawValue.capitalized }
}
