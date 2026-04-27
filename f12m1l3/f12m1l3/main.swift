//
//  main.swift
//  f12m1l3
//
//  Created by misha gezha on 06.04.2026.
//

import Foundation

// MARK: Урок 3 - Массивы
/*
 Задание #1
 > Создай массив из 5 любых чисел. Выведи каждое число на экран с помощью for-in.
 */
var a: [Int] = [1, 2, 3, 4, 5]
for (idx, aa) in a.enumerated() {  // for-in по массиву не даёт tuple как в js -> fix: enumerated()
	print("a[\(idx)]: \(aa)")  // ТАКЖЕ! обрати внимание что idx является первым агрументом
}

/*
 Задание #2
 > Добавь элемент в конец массива и в начало массива. Выведи результат.
 */
a.append(6)
print(a)

/*
 Задание #3
 > Удаление элементов: Удали последний элемент массива и выведи его.
 */
let b = a.removeLast()
print(b)

/*
 Задание #4
 > Доступ по индексу: Выведи первый и последний элемент массива.
 */
print(a.first!, a.last!)  // сахар
print(a[0], a[a.count - 1])

/*
 Задание #5
 > Сумма элементов: Посчитай сумму всех чисел массива и выведи результат.
 */
var sum = 0
for aa in a {
	sum += aa
}
print(sum)
print(a.reduce(0, +))  // сахар

/*
 Задание #6
 > Поиск элемента: Проверь, содержит ли массив число 10, и выведи соответствующее сообщение. Используйте следущий метод.
	 let isContains = users.contains("Petr")// возвращает true/false в зависимости от наличии указанного значения в массиве
 */
let randBool: Bool = .random()  // === let randBool: Bool = (Int.random(in: 0...1) == 1)
if randBool {
	let idx = Int.random(in: 0...a.count)
	a.insert(10, at: idx)
	print("🫪: a.insert(10, at: \(idx))")
}
let fIdx = a.firstIndex(of: 10)
if let fIdx {
	print("10 -> a[\(fIdx)] (by firstIndex)")
} else {
	print("idx not found (by firstIndex)")
}
print((a.contains(10) ? "gotcha" : "idx not found") + " (by contains)")

/*
 Задание #7
 > Длина массива: Выведи количество элементов в массиве.
 */
print("size/count/length: \(a.count)")

/*
 Задание #8
 > Замена элемента: Замени третий элемент массива на другое значение.
 */
//a[3] = "🍏" // ! Cannot assign value of type 'String' to subscript of type 'Int'
a[3] = 99
print(a)

// MARK: - next level
let fruits = ["banana", "orange", "🍏", "kiwi"]

/*
 Задание #1
 > Проверить, есть ли слово "apple" в массиве
 */
print((fruits.contains("🍏") ? "gotcha" : "apple not found"))

/*
 Задание #2
 > Отсортировать массив по алфавиту
 */
let asc = fruits.sorted()
print(asc)
let desc = fruits.sorted(by: >)
print(desc)
print(fruits)  // проверка не мутирует ли исходный массив (НЕТ СЛАВО БОГУ)

var fruits2 = fruits.map { $0 }  // array clone
let desc2 = fruits2.sorted(by: >)
print(fruits2)
print(desc2)

/*
 Задание #3
 > Создать массив String и вывести все значениея, длина которых больше 5
 */
print("🍏: \("🍏".count)")
print("🫪: \("🫪".count)")
print("₹: \("₹".count)")

print("🍏 utf8: \("🍏".utf8.map { $0 })")
print("🫪 utf8: \("🫪".utf8.map { $0 })")
print("₹ utf8: \("₹".utf8.map { $0 })")

print("🍏 utf8 count: \("🍏".utf8.count)")  // 4
print("🫪 utf8 count: \("🫪".utf8.count)")  // 7
print("₹ utf8 count: \("₹".utf8.count)")  // 7

for word in fruits {
	if word.count > 5 {
		print(word)
	}
}

for word in fruits {
	if word.utf8.count > 3 {
		print(word + " (utf8)")
	}
}

/*
 Задание #4
 > Проверить любую строку на палиндром
 */
let ex1 = "ΝΙΨΟΝΑΝΟΜΗΜΑΤΑΜΗΜΟΝΑΝΟΨΙΝ"
let ex2 = "🍏🫪🍏 "
let ex3 = " НА В ЛОБ, БОЛВАН"
let ex4 = "1234321"
let ex5 = "Умолкло „Му!“"
let ex6 = " 1"
let ex7 = "123456789"
let arr = [ex1, ex2, ex3, ex4, ex5, ex6, ex7]

print(arr)
print("-------")

for ez in arr {
	let simpleCleanStr =
		ez
		.lowercased()
		.replacingOccurrences(of: " ", with: "")
		.trimmingCharacters(in: .whitespaces)

	let isPalindrome = simpleCleanStr == String(simpleCleanStr.reversed())
	let ab = simpleCleanStr
	let ba = String(simpleCleanStr.reversed())
	print("\(ab) === \(ba) → \(isPalindrome ? "-> yes" : "-> no")")
}

print("-------")

for entity in arr {
	let trimAndSymbolFreeEnity =
		entity
		.lowercased()
		.unicodeScalars  // убивает чистый String -> становиться String.UnicodeScalarView
		.filter { $0.properties.isAlphabetic || $0.properties.numericType != nil }
		.map(Character.init)  // у String.UnicodeScalarView нет == и reversed() (не могу сравнить или развернуть)

	let isPalindrome = trimAndSymbolFreeEnity == trimAndSymbolFreeEnity.reversed()
	let ab = String(trimAndSymbolFreeEnity)
	let ba = String(trimAndSymbolFreeEnity.reversed())
	print("\(ab) === \(ba) → \(isPalindrome ? "-> yes" : "-> no")")
}

/*
 Задание #5
 > Создай массив чисел и подсчитай, сколько раз встречается число 3 в массиве.
 */
let duplicates = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 1, 5, 5, 5, 5, 5]  // [1..1] - 2 штуки!

/// через reduce
/// > https://developer.apple.com/documentation/swift/string/reduce(into:_:)#discussion
let tryReduce = duplicates.reduce(into: [Int: Int]()) { uniqEl, el in
	uniqEl[el, default: 0] += 1  // сахар: можно ставить дефолтное значения
}
print(tryReduce)

/// через while
var i = 0
var whileBuffer = [Int: Int]()

while i < duplicates.count {
	let uniqEl = duplicates[i]
	whileBuffer[uniqEl, default: 0] += 1
	i += 1
}
print(whileBuffer)

/*
 Задание #6
 > Удали все элементы массива, которые меньше 5.
 */
let filtered = duplicates.filter { $0 >= 5 }
print(filtered)

/*
 Задание #7
 > Создай массив из чисел и выведи сумму всех его элементов
 */
let fooSum = duplicates.reduce(into: 0) { $0 += $1 }
let fooSum2 = duplicates.reduce(0, +)
print(fooSum)
print(fooSum2)
