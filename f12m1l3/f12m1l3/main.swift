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
for (idx, aa) in a.enumerated() { // for-in по массиву не даёт tuple как в js -> fix: enumerated()
	print("a[\(idx)]: \(aa)") // ТАКЖЕ! обрати внимание что idx является первый агрументом
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
print(a.first!, a.last!) // сахар
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
print(a.reduce(0, +)) // сахар


/*
 Задание #6
 > Поиск элемента: Проверь, содержит ли массив число 10, и выведи соответствующее сообщение. Используйте следущий метод.
	 let isContains = users.contains("Petr")// возвращает true/false в зависимости от наличии указанного значения в массиве
 */
let randBool: Bool = .random() // === let randBool: Bool = (Int.random(in: 0...1) == 1)
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
