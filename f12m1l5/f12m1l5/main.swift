// by mioe

import Foundation

// MARK: Урок 5 - Функции
/// > https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/
/*
 Задане #1
 > Сумма чисел
	 Функция принимает массив чисел [Int] и возвращает их сумму.
	 Пример: [1, 2, 3] → 6
 */
func sum(_ numbers: [Int]) -> Int { // в swift все аргументы func именованные, _ убирает внешнюю метку аргумента
	numbers.reduce(0, +) // как в rust по дефолту return !(НО ТОЛЬКО ЕСЛИ ОДНА СТРОКА КОДА)
}
print(sum([1, 2, 3]))


/*
 Задание #2
 > Подсчет четных
	 Функция принимает массив [Int], возвращает количество четных чисел.
	 Пример: [1, 2, 3, 4] → 2
 */
func countEven(_ numbers: [Int]) -> Int {
	numbers.filter { $0.isMultiple(of: 2) }.count
}
print(countEven([1, 2, 3, 4]))


/*
 Задание #3
 > Словарь длин слов
	 Функция принимает массив слов [String], возвращает словарь [String: Int], где ключ — слово, значение — длина слова.
	 Пример: ["hi", "swift"] → ["hi": 2, "swift": 5]
 */
func setDictionary(_ words: [String]) -> [String: Int] {
	Dictionary(uniqueKeysWithValues: words.map { ($0, $0.count) })
}
print(setDictionary(["hi", "swift"]))


// MARK: - next lvl
/*
 Задание #1
 > Подсчет количества повторений
	 Функция принимает массив чисел [Int], возвращает словарь [Int: Int], где ключ — число, значение — сколько раз оно встречается.
	 Пример: [1, 2, 2, 3, 1] → [1: 2, 2: 2, 3: 1]
 */
//func groupedNum(_ numbers: [Int]) -> [Int: Int] {
//	var tmp: [Int: Int] = [:]
//	numbers.forEach { tmp[$0, default: 0] += 1 }
//	return tmp
//}
// переписал функцию чтобы переиспользовать в Задание #3
func groupedAny<T: Hashable>(_ arr: [T]) -> [T: Int] { // можно использовать дженерики
	// rust: fn gropedAny<T: Eq + Hash>(arr: &[T]) -> HashMap<&T, usize> { ... }
	// ts: function groupedAny<T extends PropertyKey>(arr: T[]): Record<T, number> { ... }
	arr.reduce(into: [:]) { $0[$1, default: 0] += 1 }
}
print(groupedAny([1, 2, 2, 3, 1]))


/*
 Задание #2
 > Слияние массивов без дубликатов
	 Функция принимает два массива [String] и возвращает массив без повторяющихся элементов.
	 Пример: ["a", "b", "c"], ["b", "c", "d"] → ["a", "b", "c", "d"]
 */
func spread(_ a: [String], _ b: [String]) -> [String] {
	Set(a + b).sorted() // Set(Arr + Arr .. + Arr) аналог в js [...[], ...[], .., ...[]]
}
print(spread(["a", "b", "c"], ["b", "c", "d"]))


/*
 Задание #3
 > Самое частое слово
	 Функция принимает массив слов [String] и возвращает слово, которое встречается чаще всего.
	 Если таких слов несколько — вернуть любое.
	 Пример: ["apple", "banana", "apple", "orange"] → "apple"
 */
func getTopWord(_ words: [String]) -> String {
	groupedAny(words).max(by: { $0.value < $1.value })!.key
}
print(getTopWord(["apple", "banana", "apple", "orange"]))
