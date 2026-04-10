// by mioe

import UIKit

class SettingsViewController: UIViewController {
	/// утечка паняти смотри что не срабатывает деструктуризатор deinit
//	lazy var routerPop: UIAction = UIAction { _ in
//		self.navigationController?.popViewController(animated: true)
//	}
	
	lazy var routerPop: UIAction = UIAction { [weak self] _ in
		self?.navigationController?.popViewController(animated: true)
	}
	
	lazy var routerLink: UIButton = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setTitle("Сохранить", for: .normal)
		$0.setTitleColor(.white, for: .normal)
		$0.backgroundColor = .systemGreen
		$0.layer.cornerRadius = 14
		$0.heightAnchor.constraint(equalToConstant: 40).isActive = true
		return $0
	}(UIButton(primaryAction: routerPop))
	
	override func viewWillAppear(_ animated: Bool) {
		print("sttg: \(#function) - onBeforeMount")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		print("sttg: \(#function) - onAfterTransition")
	}
	
	override func viewDidLoad() {
		print("sttg: \(#function) - setup") // v-if=toggle если будет освобождать память то при вызове сработает снова
		
		super.viewDidLoad()
		view.backgroundColor = .white
		title = "Настройки"
		
		view.addSubview(routerLink)
		
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never
		
		NSLayoutConstraint.activate([
			// routerLink
			routerLink.bottomAnchor.constraint(
				equalTo: view.bottomAnchor,
				constant: -32
			),
			routerLink.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			routerLink.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
		])
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		print("sttg: \(#function) - onBeforeUnmount")
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		print("sttg: \(#function) - onUnmounted")
	}
	
	deinit {
		print("deinit SettingsViewController")
	}
}
