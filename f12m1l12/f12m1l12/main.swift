// by mioe

import Foundation

// MARK: Урок 12 - Closure
/*
 Задание #1
 > Создай клоужер, который просто выводит "Hello, Swift!"
	 // Твоя задача
	 let hello = /* ? */
	 hello()
 */
let hello: () -> Void = { // обычная стрелочная функция из js/rust
	print("Hello, Swift!")
}
hello()


/*
 Задание #2
 > Создай клоужер, который принимает имя и выводит приветствие.
	 // Твоя задача
	 let greet: (String) -> Void = /* ? */
	 greet("Student")
 */
let greet: (String) -> Void = { name in
	print("Hello, \(name)!")
}
greet("Student")


/*
 Задание #3
 > Создай клоужер, который принимает два числа и возвращает их сумму.
	 // Твоя задача
	 let add:(Int,Int) -> Int = /* ? */
	 print(add(2, 3)) // 5
 */
let add: (Int, Int) -> Int = { (a, b) in
	return a + b
}
print(add(2, 3))


/*
 Задание #4
	 > Создай функцию, которая принимает клоужер(простой, ничего не принимает и не возвращает () -> Void) и вызывает его.
	 func doSomething(??){
	 // ?
	 }
	 doSomething {
	 print("Действие выполнено!")
	 }
 */
func eventLoop(closure: () -> Void) {
	closure()
}
let closure: () -> Void = {
	print("tick")
}
eventLoop(closure: closure)


/*
 Задание #5
 > Функция должна принять клоужер, который принимает число и печатает его квадрат.
 */
let sqrt = { (num: Int) in
	return num * num
}
eventLoop { print(sqrt(3)) } // callback function( () => { log } )
