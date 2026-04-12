// by mioe

import Foundation

struct TableModel {
	let header: String
	let footer: String?
	var rows: [TableRowModel]
	
	static func mock() -> [TableModel] {
		[
			// Компьютерные игры
			TableModel(
				header: "Games",
				footer: "Upcoming & beloved indie titles",
				rows: [
					TableRowModel(title: "Hollow Knight: Silksong", subtitle: "Team Cherry", image: "image00", detail: .new),
					TableRowModel(title: "Hades II", subtitle: "Supergiant Games", image: "image01", detail: .new),
					TableRowModel(title: "Celeste 2", subtitle: "Maddy Makes Games", image: "image02", detail: .sale),
					TableRowModel(title: "Elden Ring", subtitle: "FromSoftware", image: "image03", detail: .common),
					TableRowModel(title: "Disco Elysium", subtitle: "ZA/UM", image: "image04", detail: .common),
				]
			),
			// Сериалы Apple TV+
			TableModel(
				header: "Apple TV+ Series",
				footer: nil,
				rows: [
					TableRowModel(title: "Severance", subtitle: "Dan Erickson", image: "image10", detail: .new),
					TableRowModel(title: "Ted Lasso", subtitle: "Bill Lawrence, Jason Sudeikis", image: "image11", detail: .common),
					TableRowModel(title: "The Morning Show", subtitle: "Jay Carson", image: "image12", detail: .common),
					TableRowModel(title: "Foundation", subtitle: "David S. Goyer", image: "image13", detail: .new),
					TableRowModel(title: "Silo", subtitle: "Graham Yost", image: "image14", detail: .common),
				]
			),
			// Покемоны
			TableModel(
				header: "Pokémon",
				footer: nil,
				rows: [
					TableRowModel(title: "Pikachu", subtitle: "Electric", image: "image20", detail: .common),
					TableRowModel(title: "Charizard", subtitle: "Fire / Flying", image: "image21", detail: .sale),
					TableRowModel(title: "Bulbasaur", subtitle: "Grass / Poison", image: "image22", detail: .new),
					TableRowModel(title: "Gengar", subtitle: "Ghost / Poison", image: "image23", detail: .common),
					TableRowModel(title: "Eevee", subtitle: "Normal", image: "image24", detail: .common),
				]
			),
		]
	}
}
