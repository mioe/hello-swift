// by mioe

import Foundation

// MARK: Урок 9 - Класс
/*
 Задание #1
 > Простой класс "Человек"
	 Создай класс Person с полями name (String) и age (Int).
	 Добавь метод sayHello(), который печатает "Привет, меня зовут \(name)".
	 Создай несколько экземпляров и вызови метод.
 */
class Person {
	var name: String
	var age: Int
	
	init(name: String, age: Int) { // типичный конструктор
		self.name = name
		self.age = age
	}
	
	func sayHello() {
		print("Привет, меня зовут \(name)")
	}
	
	/*
	 Задание #3
	 > Метод, изменяющий состояние
		 Добавь метод celebrateBirthday(), который увеличивает возраст на 1.
		 Проверь, что возраст действительно увеличивается.
	 */
	func celebrateBirthday() {
		self.age += 1
	}
}
let duck = Person(name: "duck", age: 10)
duck.sayHello()


/*
 Задание #2
 > Класс "Машина" и водитель
	 Создай класс Car с полями model и owner: Person?.
	 Добавь метод assignOwner(_:), который "сажает" человека в машину.
	 Создай пару машин и людей, назначь владельцев.
 */
class Car {
	var model: String
	var owner: Person?
	
	init(model: String) {
		self.model = model
	}
	
	func assignOwner(_ owner: Person) {
		self.owner = owner
	}
}
let car = Car(model: "rusty lake")
car.assignOwner(duck)
print(car.model, " ", car.owner!.name, car.owner!.age)
duck.celebrateBirthday()
print(car.model, " ", car.owner!.name, car.owner!.age)


/*
 Задание #3
 > Наследование
	 Создай класс Animal с полем name и методом makeSound().
	 Создай классы-наследники Dog и Cat, переопредели метод makeSound(), чтобы собака лаяла, а кошка мяукала (вывести в принте).
 */
class Animal {
	var name: String
	
	init(name: String) {
		self.name = name
	}
	
	func makeSound() {
		print("no sound")
	}
}

class Cat: Animal {
	override func makeSound() {
		print("meow")
	}
}

class Dog: Animal {
	/*
	 Задание #5
	 >  Расширенный инициализатор
		 В Dog добавь новое поле breed (порода) и переопредели инициализатор, чтобы он принимал породу.
		 Создай несколько собак с разными породами.
	 */
	var breed: String
	
	init(name: String, breed: String) {
		// super.init(name: name) - !ERR swift требует строгий порядок
		self.breed = breed // свойства класс
		super.init(name: name) // после только родителя
	}
	
	override func makeSound() {
		print("woof")
	}
}

let cat = Cat(name: "cat")
cat.makeSound()
let dog = Dog(name: "dog", breed: "dogdog")
dog.makeSound()
print(dog.breed)


/*
 Задание #6
 > Создай класс Product с названием и ценой.
	 Создай класс Store, который хранит массив товаров и метод printCatalog().
	 Добавь метод sell(productName:), который удаляет товар из каталога.
	 Создай магазин, добавь товары, продай один товар, снова выведи каталог.
 */
class Product {
	var name: String
	var price: Int
	
	init(name: String, price: Int) {
		self.name = name
		self.price = price
	}
}

class Store {
	var products: [Product]
	
	init(products: [Product]) {
		self.products = products
	}
	
	func printCatalog() {
		print("store catalog:")
		for product in products {
			print("\t * \(product.name) : \(product.price)")
		}
	}
	
	func sell(productName: String) {
		guard let index = products.firstIndex(where: { $0.name == productName }) else {
			print("❌ : \(productName) not found")
			return
		}
		let sold = products.remove(at: index)
		print("✅ : \(sold.name) : \(sold.price)")
	}
}

let apple = Product(name: "🍎", price: 5)
let orange = Product(name: "🍊", price: 10)
let banana = Product(name: "🍌", price: 15)

let store = Store(products: [apple, apple, orange, banana])
store.printCatalog()
store.sell(productName: "🍎")
store.printCatalog()
store.sell(productName: "🍎")
store.printCatalog()
store.sell(productName: "🍎") // кончились


// MARK: - памятка
// Ключевое отличие class vs struct:
// struct - значимый тип, методы мутации требуют mutating (что-то похожее на обычные объекты в js)
// class - ссылочный тип, мутация без mutating, экземпляр можно менять даже через let (как обычно )
