// by mioe

import Foundation

// MARK: Урок 8 - Повтороение структур. Вычисляемые значения
// MARK: - computed - Вычисляемые свойства
/*
 Задание #1
 > Температурный конвертер
	 Создай структуру Temperature с полем celsius: Double.
	 Добавь вычисляемое свойство fahrenheit: Double, которое считает температуру в Фаренгейтах.
 */
struct Temperature {
	var celsius: Double
	
	var fahrenheit: Double { // computed
		return celsius * 9/5 + 32
	}
}
print(Temperature(celsius: 36).fahrenheit)


/*
 Задание #2
 > Создай структуру Rectangle с width и height.
	 Добавь вычисляемое свойство perimeter, которое возвращает периметр.
 */
struct Rectangle {
	var width: Double
	var height: Double
	
	var perimeter: Double {
		return 2 * width + 2 * height
	}
}
print(Rectangle(width: 10, height: 5).perimeter)


/*
 Задание #3
 > Банковский счёт
	 Создай структуру BankAccount с полем balance: Double.
	 Добавь вычисляемое свойство formattedBalance: String, которое возвращает строку вида "Ваш баланс: 1 000".
	 Добавь вычисляемое свойство isOverdrawn: Bool — true, если balance < 0
 */
struct BankAccount {
	var balance: Double
	
	var formattedBalance: String {
		return "Ваш баланс: \(balance)"
	}
	
	var isOverdrawn: Bool {
		return balance < 0
	}
}

var account = BankAccount(balance: 1_000_000) // числовой литерал работает
print(account.formattedBalance)
print(account.isOverdrawn)

account.balance = account.balance - 999_999.999_999
print(account.formattedBalance)
print(account.isOverdrawn)

account.balance = -1
print(account.formattedBalance)
print(account.isOverdrawn)


/*
 Задание #4
 >  Задача про корзину покупок
	 Создай структуру CartItem с name: String, pricePerItem: Double, quantity: Int.
	 Добавь вычисляемое свойство totalPrice, которое возвращает итоговую стоимость (pricePerItem * quantity).
 */
struct CartItem {
	var name: String
	var pricePerItem: Double
	var quantity: Int
	
	var totalPrice: Double {
		pricePerItem * Double(quantity)
	}
}

struct Cart {
	static let id = UUID() // static свойства принадлежат типу, а не экземпляру, print не покажет id
	var items: [CartItem]
	
	var totalPrice: Double {
		items.reduce(0) { $0 + $1.totalPrice }
	}
}

let duck = CartItem(name: "duck", pricePerItem: 3.5, quantity: 2)
let goose = CartItem(name: "goose", pricePerItem: 1, quantity: 3)
let cart = Cart(items: [duck, goose])
print(cart)
print(cart.totalPrice)


// MARK: - get/set - Наблюдатели свойств
/*
 Задание #1
 > Счётчик лайков
 Создай структуру Post с полем likes: Int.
 Добавь didSet, который печатает "Лайков стало \(likes)" после каждого изменения.
 */
struct Post {
	var likes: Int {
		didSet {
			print("Лайков стало \(likes)")
		}
	}
}
var post = Post(likes: 0)
post.likes += 1
post.likes += 1_000_000
post.likes -= 1


/*
 Задание #2
 > Счётчик шагов
	 Создай структуру StepTracker с полем steps: Int.
	 Добавь didSet, который печатает прогресс: "Сегодня пройдено \(steps) шагов".
	 Если steps превысили 10_000 — выведи "Цель достигнута!"
 */
struct StepTracker {
	var steps: Int {
		didSet {
			if steps > 10_000 {
				print("Цель достигнута!")
			} else {
				print("Сегодня пройдено \(steps) шагов")
			}
		}
	}
}
var tracker = StepTracker(steps: 0)
tracker.steps += 1
tracker.steps += 100
tracker.steps += 10_000


/*
 Задание #3
 > Счётчик денег
	 Создай структуру Wallet с полем money: Double.
	 В didSet проверяй, если money < 0 — печатай "У вас долг!".
	 Если money > oldValue — печатай "Поступление: \(money - oldValue)".
	 Если money < oldValue — печатай "Трата: \(oldValue - money)".
 */
struct Wallet {
	var money: Double {
		didSet {
			if money < 0 {
				print("У вас долг!")
			} else if money > oldValue {
				print("Поступление: \(money - oldValue)")
			} else if money < oldValue {
				print("Трата: \(oldValue - money)")
			}
		}
	}
}
var wallet = Wallet(money: 0)
wallet.money += 100
wallet.money -= 100
wallet.money -= 1_000_000
print(wallet)
wallet.money += 1_000_000


/*
 Задание #4
 > Проверка пароля
	 Создай структуру UserAccount с полем password: String.
	 В willSet проверь, если новый пароль короче 6 символов — напечатай "Пароль слишком короткий!".
	 В didSet выведи "Пароль обновлён" (если он не пустой).
 */
struct UserAccount {
	var password: String {
		willSet {
			if newValue.count < 6 {
				print("Пароль слишком короткий!")
			}
		}
		didSet {
			if !password.isEmpty {
				print("Пароль обновлён")
			}
		}
	}
}
var duckduck = UserAccount(password: "123456")
duckduck.password = "12345"
duckduck.password = "123456789"
