// by mioe

import UIKit

class ViewController: UIViewController {

	lazy var routerPush: UIAction = UIAction { [weak self] _ in
		// 1
		let settingsView = SettingsViewController()

		// 2
		self?.navigationController?.pushViewController(settingsView, animated: true)
	}

	lazy var header: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.heightAnchor.constraint(equalToConstant: 100).isActive = true  // костыль но нужно фиксировать высоту
		
		let picture = UIImageView()
		picture.translatesAutoresizingMaskIntoConstraints = false
		let username = UILabel()
		username.translatesAutoresizingMaskIntoConstraints = false
		let userold = UILabel()
		userold.translatesAutoresizingMaskIntoConstraints = false
		let centerY = UIView()
		centerY.translatesAutoresizingMaskIntoConstraints = false

		centerY.addSubview(username)
		centerY.addSubview(userold)
		$0.addSubview(picture)
		$0.addSubview(centerY)

		picture.image = ._1775640178368
		picture.clipsToBounds = true
		picture.layer.cornerRadius = 50

		username.text = "гежа михаил"
		username.font = .systemFont(ofSize: 18, weight: .bold)

		userold.text = "20 лет"
		userold.font = .systemFont(ofSize: 16, weight: .regular)
		userold.textColor = .systemGray

		NSLayoutConstraint.activate([
			// picture
			picture.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
			picture.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
			picture.widthAnchor.constraint(equalToConstant: 100),
			picture.heightAnchor.constraint(equalToConstant: 100),

			// centerY container
			centerY.centerYAnchor.constraint(equalTo: picture.centerYAnchor),
			centerY.leadingAnchor.constraint(
				equalTo: picture.trailingAnchor,
				constant: 16
			),

			// username
			username.topAnchor.constraint(equalTo: centerY.topAnchor),
			username.leadingAnchor.constraint(equalTo: centerY.leadingAnchor),
			username.trailingAnchor.constraint(equalTo: centerY.trailingAnchor),

			// userold
			userold.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 4),
			userold.leadingAnchor.constraint(equalTo: centerY.leadingAnchor),
			userold.bottomAnchor.constraint(equalTo: centerY.bottomAnchor),
		])
		return $0
	}(UIView())

	lazy var article: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false

		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false

		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		
		let btn = UIButton(primaryAction: routerPush)
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Редактировать", for: .normal)
		btn.setTitleColor(.white, for: .normal)
		btn.backgroundColor = .black
		btn.layer.cornerRadius = 14
		btn.heightAnchor.constraint(equalToConstant: 40).isActive = true

		$0.addSubview(title)
		$0.addSubview(text)
		$0.addSubview(btn)

		title.text = "About"
		title.font = .systemFont(ofSize: 16, weight: .bold)

		text.text = """
			Специализируюсь на Vue3/Astro, TypeScript, Nest/Hono и PostgreSQL. Строю продукты с нуля и масштабирую существующие: от архитектуры фронтенда до CI/CD и биллинговых систем. Умею нанимать, менторить и растить разработчиков внутри команды.
			
			 В свободное время слежу за новостями в мире IT, изучаю новые технологии и пробую применять их в личных проектах.
			
			 🐥🐥🐤
			"""
		text.font = .systemFont(ofSize: 16, weight: .regular)
		text.numberOfLines = 0

		NSLayoutConstraint.activate([
			// title
			title.topAnchor.constraint(
				equalTo: $0.topAnchor,
				constant: 0
			),
			title.leadingAnchor.constraint(
				equalTo: $0.leadingAnchor,
				constant: 0
			),
			title.trailingAnchor.constraint(
				equalTo: $0.trailingAnchor,
				constant: 0
			),
			
			// text
			text.topAnchor.constraint(
				equalTo: title.bottomAnchor,
				constant: 16
			),
			text.leadingAnchor.constraint(
				equalTo: $0.leadingAnchor,
				constant: 0
			),
			text.trailingAnchor.constraint(
				equalTo: $0.trailingAnchor,
				constant: 0
			),
			
			// btn
			btn.topAnchor.constraint(
				equalTo: text.bottomAnchor,
				constant: 64
			),
			btn.leadingAnchor.constraint(
				equalTo: $0.leadingAnchor,
				constant: 0
			),
			btn.trailingAnchor.constraint(
				equalTo: $0.trailingAnchor,
				constant: 0
			),
		])

		return $0
	}(UIView())

	// onBeforeMount - vue3 lifecircle
	override func viewWillAppear(_ animated: Bool) {
		// в uikit используется для перерисовки данных
		print("root: \(#function) - onBeforeMount")  // #function - имба) - вывод название функции, для дебага прикольно
	}

	// onAfterTransition - vue3 transition-api
	override func viewDidAppear(_ animated: Bool) {
		// для сброса формы
		print("root: \(#function) - onAfterTransition")
	}

	override func viewDidLoad() {
		print("root: \(#function) - setup")  // root только при холодном запуске приложения

		super.viewDidLoad()
		view.backgroundColor = .white
		title = "Главная"

		view.addSubview(header)
		view.addSubview(article)

		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "gear"),
			style: .plain,
			target: self,
			action: #selector(handleSettings)
		)

		NSLayoutConstraint.activate([
			// header
			header.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 0
			),
			header.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			header.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			
			// article
			article.topAnchor.constraint(
				equalTo: header.bottomAnchor,
				constant: 32
			),
			article.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			article.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			
			// не работает article еще не занимает height
//			// routerLink
//			routerLink.topAnchor.constraint(
//				equalTo: article.topAnchor,
//				constant: 16
//			),
//			routerLink.leadingAnchor.constraint(
//				equalTo: view.leadingAnchor,
//				constant: 32
//			),
//			routerLink.trailingAnchor.constraint(
//				equalTo: view.trailingAnchor,
//				constant: -32
//			),
		])
	}

	@objc
	func handleSettings() {
		let settingsView = SettingsViewController()
		//		self.present(settingsView, animated: true) // вне навигации
		navigationController?.pushViewController(settingsView, animated: true)
	}

	// onBeforeUnmount - vue3 lifecircle
	override func viewWillDisappear(_ animated: Bool) {
		// проверка перед уходом с экрана - уведомления что не сохранили данных
		print("root: \(#function) - onBeforeUnmount")
	}

	// onUnmounted - vue3 lifecircle
	override func viewDidDisappear(_ animated: Bool) {
		print("root: \(#function) - onUnmounted")
	}

	deinit {
		print("deinit [root] ViewController")
	}
}
