// by mioe

import Foundation

struct TableModel {
	let header: String
	let footer: String?
	let rows: [TableRowModel]
	
	static func mock() -> [TableModel] {
		[
			// Компьютерные игры
			TableModel(
				header: "Games",
				footer: "Upcoming & beloved indie titles",
				rows: [
					TableRowModel(title: "Hollow Knight: Silksong", subtitle: "Team Cherry", detail: .common),
					TableRowModel(title: "Hades II", subtitle: "Supergiant Games", detail: .common),
					TableRowModel(title: "Celeste 2", subtitle: "Maddy Makes Games", detail: .common),
					TableRowModel(title: "Elden Ring", subtitle: "FromSoftware", detail: .common),
					TableRowModel(title: "Disco Elysium", subtitle: "ZA/UM", detail: .common),
				]
			),
			// Сериалы Apple TV+
			TableModel(
				header: "Apple TV+ Series",
				footer: nil,
				rows: [
					TableRowModel(title: "Severance", subtitle: "Dan Erickson", detail: .common),
					TableRowModel(title: "Ted Lasso", subtitle: "Bill Lawrence, Jason Sudeikis", detail: .common),
					TableRowModel(title: "The Morning Show", subtitle: "Jay Carson", detail: .common),
					TableRowModel(title: "Foundation", subtitle: "David S. Goyer", detail: .common),
					TableRowModel(title: "Silo", subtitle: "Graham Yost", detail: .common),
				]
			),
			// Покемоны
			TableModel(
				header: "Pokémon",
				footer: nil,
				rows: [
					TableRowModel(title: "Pikachu", subtitle: "Electric", detail: .common),
					TableRowModel(title: "Charizard", subtitle: "Fire / Flying", detail: .common),
					TableRowModel(title: "Bulbasaur", subtitle: "Grass / Poison", detail: .common),
					TableRowModel(title: "Gengar", subtitle: "Ghost / Poison", detail: .common),
					TableRowModel(title: "Eevee", subtitle: "Normal", detail: .common),
				]
			),
		]
	}
}
