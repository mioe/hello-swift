// by mioe

import Foundation
import SwiftData

enum AppSchemaV1: VersionedSchema {
	static var versionIdentifier = Schema.Version(1, 0, 0)

	static var models: [any PersistentModel.Type] {
		[
			SeedMigration.self, Category.self, Attachment.self, Yummy.self,
			Ticket.self, History.self,
		]
	}

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

	// MARK: - OrderStatus
	enum OrderStatus: String, Codable, CaseIterable {
		case pending, completed
	}

	// MARK: - Category
	@Model
	final class Category {
		@Attribute(.unique) var id = UUID()
		var name: String  // "Beverages"
		var sortOrder: Int  // Для порядка отображения категорий

		@Relationship(deleteRule: .cascade, inverse: \Yummy.category)
		var yummies: [Yummy] = []

		@Transient
		var menusCount: Int { yummies.count }

		init(
			name: String,
			sortOrder: Int = 0
		) {
			self.name = name
			self.sortOrder = sortOrder
		}
	}

	// MARK: - Attachment
	@Model
	final class Attachment {
		@Attribute(.unique) var id = UUID()
		var name: String
		var mimeType: String?
		var fileSize: Int64?
		var createdAt = Date()

		@Attribute(.externalStorage)
		var data: Data?

		init(
			id: UUID = UUID(),
			name: String,
			mimeType: String? = nil,
			fileSize: Int64? = nil,
			data: Data? = nil,
			createdAt: Date = .now
		) {
			self.id = id
			self.name = name
			self.mimeType = mimeType
			self.fileSize = fileSize
			self.data = data
			self.createdAt = createdAt
		}
	}

	// MARK: - Yummy (товар-вкусняшка)
	@Model
	final class Yummy {
		// required
		@Attribute(.unique) var id = UUID()
		var name: String  // "Hot Sweet Indonesian Tea"
		var info: String  // !description конфликтует с CustomStringConvertible
		var category: Category
		var basePrice: Decimal  // цена за Sm
		var createdAt = Date()

		/// optional
		@Relationship(deleteRule: .cascade)
		var image: Attachment?

		var originalPrice: Decimal?  // зачёркнутая ($9.5)
		var availableSizes: [YummySize]

		/// метаданные
		var rating: Double
		var isFeatured: Bool  // размещение в блок "Featured Beverages"
		var isPromoted: Bool  // размещение в блок "Promotion"

		init(
			name: String,
			info: String,
			category: Category,
			basePrice: Decimal,
			originalPrice: Decimal? = nil,
			availableSizes: [YummySize] = [],
			rating: Double = 0,
			isFeatured: Bool = false,
			isPromoted: Bool = false
		) {
			self.name = name
			self.info = info
			self.category = category
			self.basePrice = basePrice
			self.originalPrice = originalPrice
			self.availableSizes = availableSizes
			self.rating = rating
			self.isFeatured = isFeatured
			self.isPromoted = isPromoted
		}

		func price(for size: YummySize) -> Decimal {
			basePrice * size.priceMultiplier
		}

		@Transient
		var hasDiscount: Bool {
			guard let originalPrice else { return false }
			return originalPrice > basePrice
		}
	}

	// MARK: - Ticket (позиция в заказе - весторанные билет-заказ)
	@Model
	final class Ticket {
		@Attribute(.unique) var id = UUID()
		var quantity: Int
		var size: YummySize
		var createdAt = Date()

		// snapshot'ы: товар могут удалить, а в истории цифры остаются
		var nameSnapshot: String
		var priceAtSnapshot: Decimal

		// .nullify - товар может исчезнуть, тикет выживает
		var yummy: Yummy?

		// обратная связь на заказ
		var history: History?

		init(yummy: Yummy, quantity: Int, size: YummySize) {
			self.quantity = quantity
			self.size = size
			self.nameSnapshot = yummy.name
			self.priceAtSnapshot = yummy.price(for: size)
			self.yummy = yummy
		}

		@Transient
		var subtotal: Decimal { priceAtSnapshot * Decimal(quantity) }
	}

	// MARK: - History (история заказов)
	@Model
	final class History {
		@Attribute(.unique) var id = UUID()
		var orderedAt: Date
		var totalPrice: Decimal
		var status: OrderStatus
		var createdAt = Date()

		// cascade - удалили заказ, удалились все тикеты !
		@Relationship(deleteRule: .cascade, inverse: \Ticket.history)
		var tickets: [Ticket] = []

		init(tickets: [Ticket], status: OrderStatus = .pending) {
			self.orderedAt = .now
			self.tickets = tickets
			self.totalPrice = tickets.reduce(Decimal(0)) { $0 + $1.subtotal }
			self.status = status
		}
	}
}
