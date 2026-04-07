// by mioe

import Foundation

// MARK: Урок 6 - Enum
/*
 Задание #1
 > Направления движения (без rawValue)
	 Создай enum Direction с вариантами .north, .south, .east, .west.
	 Напиши функцию move(direction:), которая выводит текст в консоль:
	 "Go up" для .north
	 "Go down" для .south
	 "Go right" для .east
	 "Go left" для .west
	 Вызови её с разными направлениями.
 */
enum Direction {
	case north
	case south
	case east
	case west
}

func move(direction: Direction) {
	switch direction {
	case .north:
		print("Go up")
	case .south:
		print("Go down")
	case .east:
		print("Go right")
	case .west:
		print("Go left")
	}
}
move(direction: .east)


/*
 Задание #2
 > Игровые уровни
	 Создай enum GameLevel: String с вариантами "Easy", "Medium", "Hard".
	 Напиши функцию, которая принимает строку, преобразует её в enum и выводит сообщение.
	 Если строка не соответствует ни одному уровню, выводи "Unknown level".
 */
enum GameLevel: String {
	case easy = "Easy"
	case medium = "Medium"
	case hard = "Hard"
}
func getGameLevel(_ str: String) {
	// !всегда должен выходить (return, throw, break, continue)
	guard let lvl = GameLevel(rawValue: str) else { // сахар валидатор с выводом значения, типа if (false) { return } else { return valid }
		print("Unknown level")
		return
	}
	
	switch lvl {
	case .easy:
		print(GameLevel.easy.rawValue)
		case .medium:
		print(GameLevel.medium.rawValue)
		case .hard:
		print(GameLevel.hard.rawValue)
	}
}
getGameLevel("Easy")
getGameLevel("Hardcore")


/*
 Задание #3
 > Платёжная система
	 Создай enum Payment, где:
	 .cash(Double)
	 .card(number: String, amount: Double)
	 .crypto(wallet: String, amount: Double)
	 Напиши функцию process(payment:), которая по-разному обрабатывает оплату (например, разные сообщения в консоль).
 */
enum Payment {
	case cash(Double)
	case card(_ number: String, _ amount: Double)
	case crypto(wallet: String, amount: Double)
}

func process(payment: Payment, user: String? = nil) {
	switch payment {
	case .cash(let amount):
		print("💰 \(user.map { ": \($0) " } ?? ""): \(amount)")
	case .card(let number, let amount):
		print("♠️ \(user.map { ": \($0) " } ?? ""): \(number) : \(amount)")
	case .crypto(wallet: let wallet, amount: let amount):
		print("🎰 \(user.map { ": \($0) " } ?? ""): \(wallet) : \(amount)")
	}
}

process(payment: .cash(99.99))
process(payment: .card("its work", 102.80))
process(payment: .crypto(wallet: "ff", amount: 32))


/*
 Задание #4
 > События в приложении
	 Создай enum AppEvent:
	 .login(user: String)
	 .logout(user: String)
	 .error(message: String)
	 .purchase(user: String, amount: Double)
	 Используй switch, чтобы:
	 Вывести лог для каждого события
	 Если .purchase больше 1000 — вывести особое сообщение "Big spender!" (использовать where)
 */
enum AppEvent {
	case login(_ user: String)
	case logout(_ user: String)
	case error(_ message: String)
	case purchase(user: String, payment: Payment) // потренируюсь enum -> enum
}

func appEvent(_ event: AppEvent) {
	switch event {
	case .login(let str):
		print("👤 : \(str) : login")
	case .logout(let str):
		print("👤 : \(str) : logout")
	case .error(let str):
		print("❗️ : \(str)")
	case .purchase(user: let user, payment: let payment):
		switch payment {
		case .cash(let a) where a <= 1000:
			process(payment: payment, user: user)
		case .card(_, let a) where a <= 1000:
			process(payment: payment, user: user)
		case .crypto(wallet: _, amount: let a) where a <= 1000:
			process(payment: payment, user: user)
		default:
			print("❗️ : \(user) : Big spender!")
		}
	}
}

appEvent(.error("404"))
appEvent(.login("duck1"))
appEvent(.logout("duck2"))

appEvent(.purchase(user: "duck3", payment: .cash(99.99)))
appEvent(.purchase(user: "duck4", payment: .card("4444 4444 4444 4444", 500.0)))
appEvent(.purchase(user: "duck5", payment: .crypto(wallet: "0x1A2B3C", amount: 999.0)))

appEvent(.purchase(user: "duck6", payment: .cash(1000.0)))
appEvent(.purchase(user: "duck7", payment: .card("4444 4444 4444 4444", 2000.0)))
appEvent(.purchase(user: "duck8", payment: .crypto(wallet: "0x1A2B3C", amount: 9999.0)))


/*
 Задание #5
 > Уведомления
	 Создай enum Notification:
	 .message(user: String, text: String)
	 .friendRequest(user: String)
	 .system(message: String)
	 Напиши функцию handle(notification:), которая выводит разные сообщения в зависимости от типа уведомления.
 */

