// by mioe

import Foundation

// MARK: Урок 13 - ARC (strong, |weak?, unnowned| - слабые)
/*
 Задание #1
 > Простые ссылки
	 Создай класс Person с полем name и распечатай, когда объект деинициализируется (deinit).
	 Создай несколько сильных ссылок (strong) на один объект и убедись, что deinit вызывается только после удаления всех ссылок.
 */
class Person {
	var name: String
	var pet: Dog?
	var validPet: ValidDog?
	init(name: String) {
		self.name = name
		print("init \(name)")
	}
	deinit {
		print("deinit \(name)")
	}
}

var duckRefStrong: Person? = Person(name: "duckRefStrong")
var duckRefRefStrong = duckRefStrong
duckRefStrong = nil  // указатель *1
// ARC - если на экземпляр не ведет ни одна СИЛЬНАЯ ссылка, то объект освобождается из RAM

duckRefRefStrong = nil  // *0 -> deinit trigger

/*
 Задание #2
 > Сильные и слабые ссылки
	 Создай класс Dog, внутри которого есть свойство owner: Person?.
	 Создай Person, у которого есть pet: Dog?.
	 Проверь, что произойдет, если обе ссылки будут strong, а потом сделай одну weak.
 */
class Dog {
	var owner: Person?
	init(owner: Person? = nil) {
		self.owner = owner
		print("init dog")
	}
	deinit {
		print("deinit dog")
	}
}
var gooseRefStrong: Person? = Person(name: "gooseRefStrong")
gooseRefStrong?.pet = Dog()
gooseRefStrong?.pet?.owner = gooseRefStrong
gooseRefStrong = nil
gooseRefStrong?.pet = nil  // deinit НЕ вызывается - утечка памяти

// Ловушка на собесах
///gooseRefStrong ──strong──► Person
///														│
///														strong (pet)
///														│
///														▼
///														Dog
///														│
///														strong (owner)
///														│
///														└──────────────► Person ← retain cycle!

class ValidDog {
	weak var owner: Person?
	init(owner: Person? = nil) {
		self.owner = owner
		print("init validDog")
	}
	deinit {
		print("deinit validDog")
	}
}
var duckduckRefStrong: Person? = Person(name: "duckduckRefStrong")  // *1
duckduckRefStrong?.validPet = ValidDog()  // *1
duckduckRefStrong?.validPet?.owner = duckduckRefStrong  // *1Personal *1ValidDog
duckduckRefStrong = nil  // *0 -> все очистится из RAM
// Порядок:
/// 1. Person Ref = 0 -> deinit Person
/// 2. Person.validPet освобождается -> validDog Ref = 0 -> deinit validDog

/*
 Задание #3
 > Closures и утечки
	 Создай класс Downloader с методом start() и замыканием onComplete.
	 Внутри start() создай замыкание, которое обращается к self.
	 Покажи, что без [weak self] объект не деинициализируется.
	 Исправь, добавив [weak self] и проверь, что deinit теперь вызывается.
 */
class DownloaderStrong {
	var path: String = "/foo.csv"
	var onComplete: (() -> Void)?
	
	func start() {
		onComplete = {
			print("onComplete \(self.path) (by downloaderStrong)")
		}
	}
	deinit {
		print("deinit downloaderStrong")
	}
}
var downloaderStrong: DownloaderStrong? = DownloaderStrong()
downloaderStrong?.start() // bind onComplete
downloaderStrong?.onComplete?() // call onComplete
downloaderStrong = nil // утечка, deinit не вызывается

class DownloaderValid {
	var path: String = "/bar.csv"
	var onComplete: (() -> Void)?
	
	func start() {
		onComplete = { [weak self] in
			guard let self else { return } // self? уже nil - выходим
			print("done: \(self.path)")
		}
	}
	deinit {
		print("deinit downloaderValid")
	}
}
var downloaderValid: DownloaderValid? = DownloaderValid()
downloaderValid?.start()
downloaderValid?.onComplete?()
downloaderValid = nil // освободили -> print deinit


// MARK: - памятка из видео (realword)
/// code:
///
///static func createLaunchView() -> UIViewController {
///	let view = LaunchView()                         // 1. создаём View
///	let presenter = LaunchViewPresenter(view: view) // 2. создаём Presenter, передаём view
///	view.presenter = presenter                      // 3. view держит presenter
///	return view                                     // 4. возвращаем view наружу
///}
/// Граф ссылок - потенциальный retain cycle
/// LaunchView ──strong──► LaunchViewPresenter
///												│
///												strong (view)
///												│
///												└──────────────► LaunchView 🔴 цикл!
///
/// Поэтому внутри LaunchViewPresenter ссылка на view должна быть weak:
///
///class LaunchViewPresenter {
///	weak var view: LaunchView?  <- иначе утечка памяти
///	init(view: LaunchView) {
///		self.view = view
///	}
///}
/// Исправленный граф:
/// LaunchView ──strong──► LaunchViewPresenter
///												│
///												weak (view)
///												│
///												└ ··········· LaunchView  ✅

// MARK: - необычный термин "фабрика - static func"
/// без фабрики — снаружи нужно знать детали сборки
///let view = LaunchView()
///let presenter = LaunchViewPresenter(view: view)
///view.presenter = presenter
///
/// с фабрикой — снаружи просто:
///let vc = LaunchModule.createLaunchView()
/// ---
/// Это инкапсуляция сборки модуля - вызывающий код не знает ни про Presenter, ни про зависимости. Часто называют Builder или Assembly в iOS архитектурах (Viper, Clean Swift).
