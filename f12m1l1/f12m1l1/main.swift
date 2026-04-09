//
//  main.swift
//  f12m1l1
//
//  Created by misha gezha on 06.04.2026.
//

import Foundation

// MARK: - Конкатинация
/// Задание #1
let firstName = "duck"
let lastName = "yellow"
let fullName = firstName + " " + lastName
print(fullName)


/// Задание #2
let computedName = "\(firstName) \(lastName)"
let age: UInt8 = 255
let q2Result = "Меня зовут " + computedName + ", и мне " + String(age) + " лет."
print(q2Result)


/// Задание #3
let size: Int = 2
var input = Array(repeating: "", count: size)
var isValid = Array(repeating: false, count: size)

for i in 0..<input.count {
	print("input: n[\(i)]")
	while (!isValid[i]) {
		input[i] = readLine()!
		isValid[i] = input[i].allSatisfy(\.isNumber)
		if (!isValid[i]) {
			print("n[\(i)]: \(input[i]) is invalid, try again")
		}
	}
}

/// Ближайший аналог в js: Array.prototype.flatMap
let strToNumber = input.compactMap(Int.init)
let sum: Int = strToNumber.reduce(0, +)
let resut = "\(input.joined(separator: " + ")) = \(sum)"
print(resut)


print("\n\n")


// MARK: Интерполяция строк
/// Задание #1
print("Меня зовут \(computedName), и мне \(age) лет.")


/// Задание #2
/// claude.sonnet4.6: помог написать input валидатор
func readDouble(_ prompt: String) -> Double {
	while true {
		print(prompt)
		if let line = readLine(), let value = Double(line), value > 0 {
			return value
		}
		print("\(prompt) is invalid, try again")
	}
}

let weight = readDouble("Введите вес (кг):")
let height = readDouble("Введите рост (м):")
let bmi = weight / (height * height)
print("Ваш ИМТ равен \(String(format: "%.2f", bmi)).")


/// Задание #3
func readInt(_ prompt: String) -> Int {
	while true {
		print(prompt)
		if let line = readLine(), let value = Int(line), value > 0 {
			return value
		}
		print("\(prompt) is invalid, try again")
	}
}

print("input: productName")
let productName = readLine()!
let price = readDouble("input: price")
let quantity = readInt("input: qty")
print("Вы добавили в корзину \(quantity) шт. товара \(productName) на сумму \(price * Double(quantity)) руб.")


print("\n\n")


// MARK: Основные типы данных
///Задание #1
let int16min: Int16 = Int16.min
let uint8200: UInt8 = 200
let pi: Double = Double.pi
let boolfalse: Bool = false
let str: String = "Swift is awesome!"

/// Задание #2
let num = readInt("input: num")
print("output: \(num * num)")

/// Задание #3
var flagIsEven = false
let inputTestInt = readInt("input: inputTestInt")
print("output: isEven \(inputTestInt.isMultiple(of: 2))")


print("\n\n")


// MARK: Переменные и константы
/// Задание #1
var currentTemperature = 15
currentTemperature = readInt("temperature now:")
print("output: \(currentTemperature)")

/// Задание #2
let birthYear = 1996
// birthYear = readInt("birth year:") // IDE: Cannot assign to value: 'birthYear' is a 'let' constant

///Задание #3
var ccount = 10
// ccount = readLine()! // любой ввод пользователя String!


print("\n\n")


// MARK: Логические значения и условные операторы
/// Задание #1
let dd = readInt("input dd:")
if (dd > 1) {
	print("Положительное число")
} else if (dd == 0) {
	print ("Ноль")
} else {
	print("Все остально, отрицательное")
}

/// Задание #2
let userAge = readInt("input userAge:")
if (userAge >= 18) {
	print("Доступ разрешён")
} else {
	print("Доступ запрещён")
}
