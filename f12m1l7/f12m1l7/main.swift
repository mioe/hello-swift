// by mioe

import Foundation

// MARK: Урок 7 - Struct
/*
 Задание #1
 > Точка на плоскости
	 Создай структуру Point с полями x и y (типа Int).
	 Создай точку (5, 7) и выведи её координаты.
 */
struct Point {
	var x: Int
	var y: Int
}
print(Point(x: 5, y: 7))


/*
 Задание #2
 > Прямоугольник и площадь
	 Создай структуру Rectangle с полями width и height.
	 Добавь метод area() → возвращает площадь.
	 Создай прямоугольник 3 x 4 и выведи его площадь.
 */
struct Rectangle {
	var width: Int
	var height: Int
	
	func area() -> Int {
		width * height
	}
}
print(Rectangle(width: 3, height: 4).area())


/*
 Задание #3
 > Сравнение
	 Создай структуру Student с полями name, grade.
	 Добавь метод isBetter(than:), который возвращает true, если grade выше.
	 Создай двух студентов и сравни их.
 */
struct Student {
	var name: String
	var grade: Int
	
	func isBetter(than other: Student) -> Bool {
		grade > other.grade
	}
}
let duck = Student(name: "duck", grade: 10)
let goose = Student(name: "goose", grade: 12)
print(duck.isBetter(than: goose))
print(goose.isBetter(than: duck))


/*
 Задание #4
 > Optional в структуре
	 Создай структуру User с полями name, email.
	 Сделай email опциональным.
	 Создай пользователя без email и выведи email только если он есть.
 */
struct User {
	var name: String
	var email: String?
}
let duckduck = User(name: "duckduck", email: nil)
let goosegoose = User(name: "goosegoose", email: "goosegoose@goosegoose.com")
print(duckduck, goosegoose)
