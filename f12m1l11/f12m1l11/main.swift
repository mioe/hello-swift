// by mioe

import Foundation

// MARK: Урок 11 - Протоколы. Quard
/// legacy
/// > https://developer.apple.com/documentation/swift/using-objective-c-runtime-features-in-swift
/// > https://developer.apple.com/documentation/objectivec/objc_registerprotocol(_:)
/// > https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/#Optional-Protocol-Requirements
@objc protocol foo {
	func bar()
	@objc optional func qwe()
}
class Foo: foo {
	func bar() {
		print("bar")
	}
}
class Bar: Foo {
	override func bar() {
		print("bar override")
	}
	func qwe() {
		print("qwe")
	}
}


/*
 Задание #1
 > Композиция через протоколы
	 Задание:
	 Создай систему плагинов:
	 Протокол Plugin с методом execute()
	 Класс App, который хранит массив [Plugin]
	 Добавь разные плагины (LoggerPlugin, AnalyticsPlugin) и вызови execute() для всех.
 */
protocol Plugin {
	func execute()
}

class App {
	var plugins: [Plugin] = []
	func add(plugin: Plugin) {
		plugins.append(plugin)
	}
	
	func run() {
		plugins.forEach { $0.execute() }
	}
}

class LoggerPlugin: Plugin {
	func execute() {
		print("init logger")
	}
}

class AnalyticsPlugin: Plugin {
	func execute() {
		print("init analytics")
	}
}

let logger = LoggerPlugin()
let analytics = AnalyticsPlugin()

let app = App()
app.add(plugin: logger)
app.add(plugin: analytics)
app.run()


/*
 Задание #2
 > Протокол для тестирования (Dependency Injection)
	 Задание:
	 Создай протокол NetworkServiceProtocol с методом fetchData() -> String.
	 Сделай два класса:
	 RealNetworkService
	 MockNetworkService
	 Используй их в ViewModel, которая не знает, какой именно сервис используется.
 */
protocol NetworkServiceProtocol {
	func fetchData() -> String
}

class RealNetworkService: NetworkServiceProtocol {
	func fetchData() -> String {
		"real world"
	}
}

class MockNetworkService: NetworkServiceProtocol {
	func fetchData() -> String {
		"mock"
	}
}

class ViewModel {
	private let networkService: NetworkServiceProtocol
	
	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}
	
	func fetch() -> String {
		networkService.fetchData()
	}
}

let realworld = ViewModel(networkService: RealNetworkService())
let mock = ViewModel(networkService: MockNetworkService())
print(realworld.fetch())
print(mock.fetch())


/*
 Задание #3
 > Наследование протоколов
	 Задание:
	 Создай Movable с методами moveForward() и moveBackward().
	 Создай Flyable, который наследует Movable и добавляет метод fly().
	 Реализуй в классе Bird.
 */
protocol Movable {
	func moveForward()
	func moveBackward()
}

protocol Flyable: Movable {
	func fly()
}

class Bird: Flyable {
	func fly() {
		print("fly")
	}
	
	func moveForward() {
		print("move forward")
	}
	
	func moveBackward() {
		print("move backward")
	}
}

let bird = Bird()
bird.fly()
bird.moveForward()
bird.moveBackward()
