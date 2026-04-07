// by mioe

import Foundation

// MARK: Урок 10 - Расширение. Протоколы
/*
 Задание #1
 > Расширение String
	 Добавь в String функцию isPalindrome(), которая проверяет, является ли строка палиндромом.
 */
extension String {
	func isPalindrome() -> Bool {
		/// > https://github.com/mioe/hello-swift/blob/669d8a673bfbfd82b92fa949fd5d48700caf7d6c/f12m1l3/f12m1l3/main.swift#L169-L179
		let trimAndSymbolFreeEnity =
			self
			.lowercased()
			.unicodeScalars
			.filter { $0.properties.isAlphabetic || $0.properties.numericType != nil }
			.map(Character.init)

		let isPalindrome =
			trimAndSymbolFreeEnity == trimAndSymbolFreeEnity.reversed()
//		let ab = String(trimAndSymbolFreeEnity)
//		let ba = String(trimAndSymbolFreeEnity.reversed())
//		print("[debug]: \(ab) === \(ba) → \(isPalindrome ? "-> yes" : "-> no")")
		return isPalindrome
	}
}

let ex1 = "ΝΙΨΟΝΑΝΟΜΗΜΑΤΑΜΗΜΟΝΑΝΟΨΙΝ"
let ex2 = "🍏🫪🍏 "
let ex3 = " НА В ЛОБ, БОЛВАН"
let ex4 = "1234321"
let ex5 = "Умолкло „Му!“"
let ex6 = " 1"
let ex7 = "123456789"
let arr = [ex1, ex2, ex3, ex4, ex5, ex6, ex7]
for item in arr {
	print(item.isPalindrome())
}


/*
 Задание #2
 > Расширение Int
	 Добавь метод squared() для Int, который возвращает квадрат числа.
 */
extension Int {
	func squared() -> Int {
		self * self
	}
}
print(3.squared())


/*
 Задача #3
 > Класс "Person"
	 Создай класс Person с полями name и age.
	 Добавь метод introduce() в расширении, который выводит в консоль: "Меня зовут name, мне age лет".
 */
class Person {
	var name: String
	var age: Int
	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
}
let duck = Person(name: "duck", age: 10)
extension Person {
	func introduce() {
		print("Меня зовут \(name), мне \(age) лет")
	}
}
duck.introduce()


/*
 Задание #4
 > Протокол "Drawable"
	 Определи протокол Drawable с методом draw().
	 Реализуй его в классе Circle и Square, чтобы они выводили в консоль описание: "Рисую круг радиусом 10" или "Рисую квадрат со стороной 5".
 */
protocol Drawable {
	func draw()
}

class Circle: Drawable {
	func draw() {
		print("Рисую круг радиусом 10")
	}
}

class Square: Drawable {
	func draw() {
		print("Рисую квадрат со стороной 5")
	}
}

let circle = Circle()
let square = Square()
circle.draw()
square.draw()


/*
 Задание #5
 > Протокол "Calculatable"
	 Определи протокол с методом calculate(a:b:) -> Int.
	 Реализуй его в структурах Adder, Multiplier
 */
protocol Calculatable {
	func calculate(a: Int, b: Int) -> Int
}

struct Adder: Calculatable {
	func calculate(a: Int, b: Int) -> Int {
		a + b
	}
}

struct Multiplier: Calculatable {
	func calculate(a: Int, b: Int) -> Int {
		a * b
	}
}

var adder = Adder()
var multiplier = Multiplier()
print(adder.calculate(a: 1, b: 2))
print(multiplier.calculate(a: 1, b: 2))


/*
  Задание #6
 > Протокол "Printable"
	 Определи протокол с методом printInfo().
	 Реализуй в Car (пусть выводит марку) и Phone (пусть выводит модель).
 */
protocol Printable {
	func printInfo()
}

class Car: Printable {
	var mark: String
	init(mark: String) {
		self.mark = mark
	}
	func printInfo() {
		print(mark)
	}
}

class Phone: Printable {
	var model: String
	init(model: String) {
		self.model = model
	}
	func printInfo() {
		print(model)
	}
}

let car = Car(mark: "audi")
let phone = Phone(model: "iphone")
car.printInfo()
phone.printInfo()


/*
 Задание #7
 > Протокол "Named"
	 Создай протокол Named с одним свойством name: String.
	 Реализуй его в классе Dog и структуре Book.
 */
protocol Named {
	var name: String { get set }
}

class Dog: Named {
	var name: String
	init(name: String) {
		self.name = name
	}
}

class Book: Named {
	var name: String
	init(name: String) {
		self.name = name
	}
}

let dog = Dog(name: "dog")
let book = Book(name: "book")
print(dog.name)
print(book.name)
