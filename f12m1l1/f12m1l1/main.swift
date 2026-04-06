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

// MARK: Интерполяция строк
/// Задание 1
