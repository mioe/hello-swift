//
//  main.swift
//  f12m1l2
//
//  Created by misha gezha on 06.04.2026.
//

import Foundation

// MARK: Урок 2 - Опицональные типы
/*
 Задание #1
 > Объяви переменную name типа String?, сначала присвой ей nil, а потом своё имя. Выведи её в консоль.
 */
var name: String? = nil
name = "duck"
print("output name: \(name ?? "nil")")  // crtl+c в терминале сбрасывает ввод, возможен null

/*
 Задание #2
 > Создай переменную age: Int? = nil. Если в age лежит число – выведи его. Если nil – выведи "Возраст не указан".
 */
let age: Int? = nil
print(age == nil ? "Возраст не указан" : "Возраст: \(age!)")

/*
 Задание #3
 > Создай переменную nickname: String? = "ErrorNil". Используя if let, выведи в консоль:
	 - "Твой ник: ErrorNil" – если значение есть
	 - "Ника нет" – если nil.
 */
let nickname: String? = "goose"
print(nickname == nil ? "Ника нет" : "Твой ник: \(nickname!)")

/*
 Задание #4
 > Пусть email: String? = nil. С помощью if let и else выведи:
	 - "Твой email: ...", если он есть
	 - "Email не задан", если nil.
 */
let email: String? = nil
if let e = email { // сахар: if true -> let e = email
	print("Твой email: \(e)")
} else {
	print("Email не задан")
}

/*
 Задание #5
 > Задай переменные и присвой значения:
	 - name: String?
	 - age: Int?
	 - city: String?
	 Далее выведии используя оператор ??:
	 - "Имя: <name>" если оно есть, иначе "Имя не указано"
	 - "Возраст: <age>" если он есть, иначе 0
	 - "Город: <city>" если он есть, иначе "Город не указан"
 */
let q5name: String? = nil
let q5age: Int? = nil
let q5city: String? = nil
print("Имя: \(q5name ?? "Имя не указано")")
print("Возраст: \(q5age ?? 0)")
print("Город: \(q5city ?? "Город не указан")")

/*
 Задание #6
 > Задана переменая var score: Int? = 85
	 С помощью if let выведи:
	 - "Отлично" – если score >= 80
	 - "Хорошо" – если score >= 50
	 - "Нужно подтянуть" – если score < 50
	 - "Нет данных" – если nil.
 */
var score: Int? = 85
if let s = score {
	print(s >= 80 ? "Отлично" : (s >= 50 ? "Хорошо" : "Нужно подтянуть"))
} else {
	print("Нет данных")
}

/*
 Задание #7
 > var numberString: String? = "42". С помощью if let, попробуй преобразовать строку в Int.
	 Если получилось – выведи "Число: 42", если нет – "Некорректное значение".
 */
var numberString: String? = "42"
if let n = Int(numberString!) {
	print("Число: \(n)")
} else {
	print("Некорректное значение")
}

/*
 Задание #8
 > Создай переменную day = 3. С помощью switch выведи:
	 - "Понедельник" если 1
	 - "Вторник" если 2
	 - "Среда" если 3
	 - "День не распознан" для всех остальных чисел.
 */
let day = 3
switch day {
case 1: print("Понедельник")
case 2: print("Вторник")
case 3: print("Среда")
default: print("День не распознан")
}

/*
 Задание #9
 > Создай переменную color = "red". С помощью switch выведи:
	 - "Стой" если красный
	 - "Жди" если жёлтый
	 - "Иди" если зелёный
	 - "Неизвестный цвет" если другой.
 */
let color = "red"
switch color {
case "red": print("Стой")
case "yellow": print("Жди")
case "green": print("Иди")
default: print("Неизвестный цвет")
}


// MARK: Доп
/*
 Задание #1
 > var numberString: String? = "123"
	 С помощью if let попробуй преобразовать её в Int.
	 Если получилось — выведи "Число: 123".
	 Если не получилось — выведи "Не удалось преобразовать".
 */
var fooNumberString: String? = "123"
if let n = Int(fooNumberString!) {
	print("Число: \(n)")
} else {
	print("Не удалось преобразовать")
}

/*
 Задание #2
 > var username: String? = "Alice"
	 var password: String? = nil
	 С помощью optional binding (if let name = username, let pass = password) выведи:
	 "Добро пожаловать, Alice!", если и имя, и пароль есть.
	 "Введите имя и пароль", если чего-то нет.
 */
var fooUsername: String? = "Alice"
var barPassword: String? = nil
if let n = fooUsername,  let _ = barPassword {
	print("Добро пожаловать, \(n)!")
} else {
	print("Введите имя и пароль")
}

/*
 Задание #3
 > var name: String? = "Bob"
	 var email: String? = nil
	 var country: String? = "Kazakhstan"
	 С помощью if let выведи "Профиль: <name>, <email>, <country>", если все три значения есть.
	 Иначе выведи "Заполните все поля".
 */
var ZooName: String? = "Bob"
var BooEmail: String? = nil
var QweCountry: String? = "Kazakhstan"
if let n = ZooName, let e = BooEmail, let c = QweCountry {
	print("Профиль: \(n), \(e), \(c)")
} else {
	print("Заполните все поля")
}

// MARK: - сахар
var p: Int? = 1
if let p { // === if let p = p - блочная scoped видимость
	print(p)
}

let t = 40
switch t {
case ..<10: print("Холодно") // можно указывать диапазон
case 10..<20: print("Нормально")
case 20...30: print("Тепло") // .. / ... - включительно
default: print("Мороз")
}
