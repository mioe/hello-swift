// by mioe

import Foundation
import SwiftData
import UIKit

enum Seed001Init: Seedable {
	static let id = "001-init"

	// MARK: - Up
	static func up(context: ModelContext) throws {
		let foods = Category(name: "Foods", sortOrder: 0)
		let beverages = Category(name: "Beverages", sortOrder: 1)
		let desserts = Category(name: "Desserts", sortOrder: 2)

		[foods, beverages, desserts].forEach { context.insert($0) }

		let yummies: [(Yummy, String?)] = [
			(
				Yummy(
					name: "Фисташковый сырок",
					info:
						"Нежный фисташковый сырок с бархатистой кремовой текстурой и тонким ореховым послевкусием. Тает во рту, оставляя лёгкую сладость и аромат свежей фисташки.",
					category: desserts,
					basePrice: 3.5,
					originalPrice: 3.0,
					availableSizes: [.md, .xl],
					rating: 4.9,
					isFeatured: true
				), "img-1"
			),
			(
				Yummy(
					name: "Фисташковое пирожное картошка",
					info:
						"Не классическая «Картошка» в изысканном фисташковом исполнении — с шелковистым кремом и тонкой белой глазурью. Орехово-сладкий аромат фисташки раскрывается с каждым кусочком, даря ощущение уютного домашнего десерта.",
					category: desserts,
					basePrice: 4.2,
					originalPrice: 4.0,
					availableSizes: [.sm, .md],
					rating: 4.7,
					isFeatured: true
				), "img-2"
			),
			(
				Yummy(
					name: "Печенье",
					info:
						"Румяное печенье с хрустящей корочкой и мягкой серединкой, посыпанное крупной морской солью. Золотистое, воздушное — с тонким балансом сладкого и солёного в каждом укусе.",
					category: desserts,
					basePrice: 2.5,
					availableSizes: [.sm, .md, .lr],
					rating: 5.0,
					isFeatured: true
				), "img-3"
			),
			(
				Yummy(
					name: "Миндальный кулич",
					info:
						"Пасхальный кулич с пышным миндально-ореховым кремом, закрученным в аппетитную спираль. Нежное тесто и насыщенная ореховая начинка создают тот самый праздничный вкус, который хочется помнить весь год.",
					category: desserts,
					basePrice: 5.8,
					originalPrice: 5.0,
					availableSizes: [.sm, .md, .lr, .xl],
					rating: 5.0,
					isFeatured: true,
					isPromoted: true,
				), "img-4"
			),
			// MARK: Beverages
			(
				Yummy(
					name: "Айс латте",
					info:
						"Бодрящий айс латте с мягкой кофейной горчинкой и шёлковой молочной пеной — лучший способ начать день. Холодный, освежающий, с тем самым балансом кофе и молока.",
					category: beverages,
					basePrice: 5.5,
					availableSizes: [.sm, .md, .lr, .xl],
					rating: 4.5,
					isPromoted: true
				), nil
			),
			(
				Yummy(
					name: "Капучино",
					info:
						"Классический капучино с бархатистой молочной пенкой и фирменным латте-арт сердцем. Насыщенный кофейный аромат и нежная сливочность — простое удовольствие в каждом глотке.",
					category: beverages,
					basePrice: 4.5,
					originalPrice: 4.0,
					availableSizes: [.md],
					rating: 4.8,
					isPromoted: true
				), nil
			),
			(
				Yummy(
					name: "Карамельный фраппе",
					info:
						"Холодный кофейный фраппе с воздушными сливками и щедрой карамельной поливкой. Сладко, кремово и бодряще — идеальный летний десерт в стакане.",
					category: beverages,
					basePrice: 5.9,
					availableSizes: [.md],
					rating: 4.6
				), nil
			),
			(
				Yummy(
					name: "Айс матча латте",
					info:
						"Освежающий айс матча латте с насыщенным травянистым вкусом японского чая и нежным молочным основанием. Бодрит мягче кофе, а цвет поднимает настроение с первого взгляда.",
					category: beverages,
					basePrice: 5.5,
					originalPrice: 4.5,
					availableSizes: [.sm, .md, .lr],
					rating: 4.7
				), nil
			),
			(
				Yummy(
					name: "Имбирный чай",
					info:
						"Согревающий напиток с лимоном, мёдом и корицей — природный антистресс в уютной кружке. Пряный аромат и кисло-сладкий вкус окутывают теплом с первого глотка.",
					category: beverages,
					basePrice: 3.8,
					availableSizes: [.sm, .md, .lr],
					rating: 4.3
				), nil
			),
			(
				Yummy(
					name: "Зелёный шёлк — Матча торт",
					info:
						"Нежный бисквит с насыщенным вкусом японской матчи и воздушным сливочным кремом между слоями. Травянистая глубина матчи и лёгкая сладость крема — идеальный дуэт.",
					category: foods,
					basePrice: 7.5,
					availableSizes: [.sm, .md],
					rating: 4.5
				), nil
			),
			(
				Yummy(
					name: "Парижское утро",
					info:
						"Хрустящий слоёный круассан с золотистой корочкой и нежным капучино с бархатистой латте-арт пенкой — классика, которая никогда не надоедает. Маслянистое, воздушное тесто и аромат свежего кофе — лучший дуэт для неспешного утра.",
					category: foods,
					basePrice: 8.5,
					availableSizes: [.sm, .md],
					rating: 4.2
				), nil
			),
			(
				Yummy(
					name: "Боул с ягодами",
					info:
						"Кремовая каша с хрустящей гранолой, спелой клубникой, черникой и бананом — питательный заряд на весь день. Свежо, сытно и красиво — как завтрак в любимом кафе.",
					category: foods,
					basePrice: 6.9,
					originalPrice: 5.9,
					availableSizes: [.md],
					rating: 4.9,
					isPromoted: true
				), nil
			),
		]

		for (yummy, assetName) in yummies {
			if let assetName {
				yummy.image = attachment(named: assetName)
			}
			context.insert(yummy)
		}
	}

	// MARK: - Down
	static func down(context: ModelContext) throws {
		try context.delete(model: Yummy.self)
		try context.delete(model: Category.self)
	}

	// MARK: - Private
	private static func attachment(named assetName: String) -> Attachment? {
		guard
			let uiImage = UIImage(named: assetName),
			let data = uiImage.jpegData(compressionQuality: 0.85)
		else { return nil }

		return Attachment(
			name: assetName,
			mimeType: "image/jpeg",
			fileSize: Int64(data.count),
			data: data
		)
	}
}
