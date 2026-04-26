// by mioe

import Foundation

// MAKR: Урок 14 - Дженеирики
/*
 Задание #1
 > Функция поиска элемента
	 Создай обобщённую функцию containsElement(_:_:), которая проверяет, содержится ли элемент в массиве.
 */
// Equatable - протокол сравнения
///contains, firstIndex, filter - требуют Equatable
func containsElement<T: Equatable>(_ el: T, _ arr: [T]) -> Bool {
	arr.contains(el)
}
let num = [1, 2, 3, 5]
print(containsElement(1, num))
print(containsElement(4, num))
let fruit = ["banana", "cherry"]
print(containsElement("banana", fruit))
print(containsElement("🍏", fruit))

let any: [Any] = [1, 2, "🍏", "banana"]
//print(containsElement(1, any)) // !ERR: Cannot convert value of type '[Any]' to expected argument type '[Int]'
//print(containsElement("🍏", any)) // !ERR: Cannot convert value of type '[Any]' to expected argument type '[String]'
/// > https://stackoverflow.com/a/56433885
/// > https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes/#Opaque-Parameter-Types
func containsAny(_ el: some Equatable, _ arr: [Any]) -> Bool {
	arr.contains { ($0 as? AnyHashable) == (el as? AnyHashable) }
}
print(containsAny(1, any))
print(containsAny(3, any))
print(containsAny("🍏", any))
print(containsAny("cherry", any))

/*
 Задание #2
 > Создать массив из двух элементов
	 Напиши функцию, которая принимает два значения одного типа и возвращает массив из них.
	 пример
	 makeArray(1, 2) → [1, 2]
 */
//func makeArray<T>(_ a: T, _ b: T) -> [T] {
//	[a, b]
//}
func makeArray<T>(_ elements: T...) -> [T] {  // так же как в js [...args] / rust args: &[T]
	elements
}
print(makeArray(1, 2))
print(makeArray("🍏", "banana", "cherry"))
print(makeArray(1, 2, 3, 4, 5))
// print(makeArray(1, "🍏")) // !ERR: Conflicting arguments to generic parameter 'T' ('String' vs. 'Int')

/*
 Задание #3
 > Напиши обобщённую функцию, которая сравнивает два значения (если тип поддерживает Equatable).
	 пример
	 isEqual("hi", "hi") → true
	 isEqual(10, 20) → false
 */
func eq<T: Equatable>(_ a: T, _ b: T) -> Bool {
	a == b
}
print(eq("hi", "hi"))
print(eq(10, 20))
print(eq(10.0, 20.0))
print(eq(20.0, 20))  // true
print(eq(10, 10.0))  // true

/*
 Задание #4
 > Напиши функцию, которая создаёт словарь из массивов ключей и значений.
	 пример
	 makeDictionary(keys: ["a", "b"], values: [1, 2]) → ["a": 1, "b": 2]
 */
func makeDictionary<K: Hashable, V>(_ k: [K], _ v: [V]) -> [K: V] {
	Dictionary(uniqueKeysWithValues: zip(k, v))  // сшиваем как в js: keys.map((k, i) => [k, v[i]]) / rust: k.iter().zip(v.iter())
}
print(makeDictionary(["a", "b"], [1, 2]))
print(makeDictionary(["a", "b"], [1, 2, 3]))  // компилятор не даст ошибки не будет но из-за разности размеров просто теряется 1 элемент

/*
 Задание #5
 > Обобщённая структура Pair
	 Создай структуру Pair, которая хранит два значения любого типа.
 */
struct Pair<T1, T2> {
	var a: T1
	var b: T2
}
let pair1 = Pair(a: 1, b: "🍏")
print(pair1.a, pair1.b)
let pair2 = Pair(a: "🍏", b: 1)
print(pair2.a, pair2.b)
let pair3 = Pair(a: 1.0, b: false)
print(pair3.a, pair3.b)

/// MARK: - next lvl
/*
 Задание #1
 > Создай класс Cache<Key, Value>, где Key: Hashable.
	 Добавь методы set, get, remove.
 */
class Redis<Key: Hashable, Value> {
	var mem: [Key: Value] = [:]
	func set(_ k: Key, _ v: Value) { mem[k] = v }
	func get(_ k: Key) -> Value? { mem[k] }
	func remove(_ k: Key) { mem.removeValue(forKey: k) }
	func all() -> [Key: Value] { mem }
}
let redis = Redis<String, String>()
let key1 = UUID().uuidString
let key2 = UUID().uuidString
let key3 = UUID().uuidString
redis.set(key1, "value1")
print(redis.get(key1)!)
redis.set(key2, "value2")
print(redis.get(key2)!)
redis.remove(key1)
redis.set(key3, "value3")
print(redis.all())


/*
 Задание #2
 > Класс KeyValueStore
	 Создай дженерик-класс для хранения пар "ключ-значение".
	 пример
	 let userAges = KeyValueStore<String, Int>()
	 userAges.set(25, for: "Alice")
	 print(userAges.get(for: "Alice") ?? 0) // 25
 */
class KeyValueStore<Key: Hashable, Value> {
	var storage: [Key: Value] = [:]
	func set(_ value: Value, for key: Key) { storage[key] = value }
	func get(for key: Key) -> Value? { storage[key] }
}
let userAges = KeyValueStore<String, Int>()
userAges.set(25, for: "Alice")
userAges.set(userAges.get(for: "Alice")! + 25, for: "Alice")
print(userAges.get(for: "Alice") ?? 0)


/*
 Задание #3
 >  Класс Logger
	 Создай класс Logger, который принимает сообщения любого типа и сохраняет их в массив.
	 пример
	 let intLogger = Logger<Int>()
	 intLogger.add(1)
	 intLogger.add(2)
	 intLogger.showAll() // 1 2
	 let stringLogger = Logger<String>()
	 stringLogger.add("Start")
	 stringLogger.add("End")
	 stringLogger.showAll() // Start End
 */
class Logger<T> {
	var storage: [T] = []
	func add(_ value: T) { storage.append(value) }
	func showAll() { print(storage.map(\.self)) }
}
let intLogger = Logger<Int>()
intLogger.add(1)
intLogger.add(2)
intLogger.showAll() // 1 2
let stringLogger = Logger<String>()
stringLogger.add("Start")
stringLogger.add("End")
stringLogger.showAll() // Start End


/*
 Задание #4
 > Создай протокол Repository, который хранит данные любого типа (ассоциативный тип) и имеет методы save и getAll. Реализуй этот протокол для дженерик класса
 */
protocol Repository {
	associatedtype T
	func save(_ value: T)
	func getAll() -> [T]
}
class RepositoryImpl<T>: Repository {
	var storage: [T] = []
	func save(_ value: T) { storage.append(value) }
	func getAll() -> [T] { storage }
}
let repo = RepositoryImpl<Int>()
repo.save(1)
repo.save(2)
print(repo.getAll()) 
