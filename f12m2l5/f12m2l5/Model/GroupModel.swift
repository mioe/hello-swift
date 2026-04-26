struct GroupModel {
	var icon: String
	var name: String
	
	static func mock(count: Int = 100) -> [GroupModel] {
		let icons = [
			"person.3.fill", "figure.2.arms.open", "building.2.fill", "house.fill",
			"gamecontroller.fill", "music.note.list", "film.fill", "sportscourt.fill",
			"fork.knife", "cup.and.saucer.fill", "book.fill", "paintbrush.fill",
			"laptopcomputer", "terminal.fill", "swift", "globe",
			"airplane", "car.fill", "bicycle", "tent.fill"
		]
		let names = [
			"iOS Developers", "Swift Community", "Design System", "Frontend Gang",
			"Backend Crew", "DevOps Chat", "AI & ML", "Open Source",
			"Coffee & Code", "Night Owls", "Early Birds", "Remote Work",
			"Startup Ideas", "Side Projects", "Game Dev", "Music Lovers",
			"Film Club", "Book Club", "Foodies", "Travel Stories",
			"Gym Bros", "Running Club", "Chess Club", "Photography",
			"Vue.js", "Rust Lang", "TypeScript", "Node.js",
			"PostgreSQL", "Docker & K8s"
		]
		
		return (0..<count).map { i in
			GroupModel(
				icon: icons[i % icons.count],
				name: names[i % names.count]
			)
		}
	}
}
