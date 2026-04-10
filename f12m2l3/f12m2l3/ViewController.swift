// by mioe

import UIKit

class ViewController: UIViewController {
	
	lazy var routerPush: UIAction = UIAction { [weak self] _ in
		// 1
		let settingsView = SettingsViewController()
		
		// 2
		self?.navigationController?.pushViewController(settingsView, animated: true)
	}
	
	lazy var routerLink: UIButton = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setTitle("settings", for: .normal)
		return $0
	}(UIButton(primaryAction: routerPush))
	
	// onBeforeMount - vue3 lifecircle
	override func viewWillAppear(_ animated: Bool) {
		// в uikit используется для перерисовки данных
		print("root: \(#function) - onBeforeMount") // #function - имба) - вывод название функции, для дебага прикольно
	}
	
	// onAfterTransition - vue3 transition-api
	override func viewDidAppear(_ animated: Bool) {
		// для сброса формы
		print("root: \(#function) - onAfterTransition")
	}
	
	override func viewDidLoad() {
		print("root: \(#function) - setup") // root только при холодном запуске приложения
		
		super.viewDidLoad()
		view.backgroundColor = .white
		title = "Главная"
		
		view.addSubview(routerLink)
		
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(handleSettings))
		
		NSLayoutConstraint.activate([
			routerLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			routerLink.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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

