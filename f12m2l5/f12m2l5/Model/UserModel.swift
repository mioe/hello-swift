// by mioe

import Foundation

struct UserModel {
	var icon: String
	var name: String
	
	static func mock(count: Int = 100) -> [UserModel] {
		let icons = [
			"person.fill", "star.fill", "heart.fill", "bolt.fill", "flame.fill",
			"moon.fill", "sun.max.fill", "cloud.fill", "leaf.fill", "pawprint.fill",
			"figure.walk", "bicycle", "car.fill", "airplane", "camera.fill", "gamecontroller.fill", "headphones", "tv.fill",
			"book.fill", "pencil", "paintbrush.fill", "hammer.fill", "wrench.fill",
			"trophy.fill", "medal.fill", "flag.fill", "map.fill", "globe",
			"house.fill", "building.2.fill", "tent.fill", "mountain.2.fill", "tree.fill",
			"fish.fill", "bird.fill", "tortoise.fill", "hare.fill", "ant.fill",
			"snowflake", "drop.fill", "wind", "tornado", "hurricane",
			"atom", "brain.fill", "eye.fill", "ear.fill", "hand.raised.fill"
		]
		let firstNames = [
			"Misha", "Anna", "Ivan", "Olga", "Dmitry",
			"Elena", "Sergey", "Maria", "Alexey", "Natasha",
			"Viktor", "Ksenia", "Pavel", "Daria", "Nikita",
			"Artem", "Lena", "Kirill", "Vera", "Roman",
			"Tanya", "Andrey", "Sasha", "Polina", "Maxim",
			"Julia", "Denis", "Ira", "Oleg", "Katya"
		]
		let lastNames = [
			"Ivanov", "Petrov", "Sidorov", "Kozlov", "Novikov",
			"Morozov", "Volkov", "Sokolov", "Popov", "Lebedev",
			"Gezha", "Smirnov", "Kuznetsov", "Fedorov", "Orlov"
		]
		
		return (0..<count).map { i in
			UserModel(
				icon: icons[i % icons.count],
				name: "\(firstNames[i % firstNames.count]) \(lastNames[i % lastNames.count])"
			)
		}
	}
}
