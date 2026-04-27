//
//  main.swift
//  f12m1l4
//
//  Created by misha gezha on 07.04.2026.
//

import Foundation

// MARK: Урок 4 - Dictionary
// MARK: - Set
/*
 Задание #1
 > Дан массив чисел:
	 let numbers = [1, 2, 3, 2, 4, 1, 5]
	 Напиши код, который убирает дубликаты и выводит уникальные числа.
 */
let numbers = [1, 2, 3, 2, 4, 1, 5]
let uniqNumbers = Set(numbers)
print(uniqNumbers)


/*
 Задание #2
 > Даны два массива:
	 let a = [1, 2, 3, 4]
	 let b = [3, 4, 5, 6]
	 Найди элементы, которые есть в обоих массивах.
 */
let a = [1, 2, 3, 4]
let b = [3, 4, 5, 6]
let intersectionEls = Set(a).intersection(Set(b))
print(intersectionEls)


/*
 Задание #3
 > Даны два множества:
	 let first: Set = [1, 2, 3, 4]
	 let second: Set = [3, 4, 5, 6]
	 Выведи те элементы, которые встречаются только в одном из них.
 */
let first: Set = [1, 2, 3, 4]
let second: Set = [3, 4, 5, 6]
let diff = first.symmetricDifference(second)
print(diff)


/*
 Задание #4
 > Дана строка:
	 let text = "Hello, world!"
	 Посчитай, сколько разных букв встречается в строке (регистр игнорировать).
 */
let text = "Hello, world!"
let uniqLetters = Set(text.lowercased().filter { $0.isLetter })
print(uniqLetters)
print(uniqLetters.count)


print("---")


// MARK: - Dictionary
/// > https://developer.apple.com/documentation/swift/dictionary#overview
/*
 Задание #1
 > Дан словарь:
	 let capitals = ["Kazakhstan": "Astana", "France": "Paris", "Japan": "Tokyo"]
	 Создай новый словарь, где ключи и значения поменяются местами (ключ — столица, значение — страна).
 */
let capitals = ["Kazakhstan": "Astana", "France": "Paris", "Japan": "Tokyo"]
let reversedCapitals = Dictionary(uniqueKeysWithValues: capitals.map { ($0.value, $0.key) }) // аналог Object.prototype js
print(reversedCapitals)


/*
 Задание #2
 > let words = ["apple", "banana", "avocado", "blueberry", "cherry", "apricot"]
	 Сгруппируй их в словарь, где ключ — первая буква слова, а значение — массив слов, начинающихся с этой буквы.
 */
let words = ["apple", "banana", "avocado", "blueberry", "cherry", "apricot"]
let groupedWords = Dictionary(grouping: words, by: { $0.first! })
print(groupedWords)


/*
 Задание #3
 > Дана строка:
	 let text = "banana"
	 Создай словарь, где ключ — это буква, а значение — сколько раз она встречается.
 */
let fooText = "banana"
let groupedFooText = fooText.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 } // как в json/object obj[key] = val
print(groupedFooText)


/*
 Задание #4
 > Дан массив голосов за кандидатов:
	 let votes = ["Alice", "Bob", "Alice", "Charlie", "Bob", "Alice"]
	 Создай словарь, где ключ — имя кандидата, а значение — количество голосов. Найди победителя (кто набрал больше всего голосов).
 */
let votes = ["Alice", "Bob", "Alice", "Charlie", "Bob", "Alice"]
let groupedVotes = votes.reduce(into: [String: Int]()) { $0[$1, default: 0] += 1 }
print(groupedVotes)


/*
 Задание #5
 > Дан массив слов:
	 let words = ["cat", "dog", "elephant", "bat", "apple"]
	 Сгруппируй их в словарь, где ключ — длина слова, а значение — массив слов этой длины.
 */
let barWords = ["cat", "dog", "elephant", "bat", "apple"]
let groupedBarWords = Dictionary(grouping: barWords, by: { $0.count })
print(groupedBarWords)
