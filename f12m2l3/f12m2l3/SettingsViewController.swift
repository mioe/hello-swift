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

	class FormFieldView: UIView {
		private let label = UILabel()
		private let textField = UITextField()

		init(label: String, placeholder: String) {
			super.init(frame: .zero)
			setup(label: label, placeholder: placeholder)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		private func setup(label: String, placeholder: String) {
			translatesAutoresizingMaskIntoConstraints = false

			self.label.translatesAutoresizingMaskIntoConstraints = false
			self.label.text = label
			self.label.font = .systemFont(ofSize: 14, weight: .medium)

			textField.translatesAutoresizingMaskIntoConstraints = false
			textField.placeholder = placeholder
			textField.font = .systemFont(ofSize: 16)
			textField.backgroundColor = .systemGray6
			textField.layer.cornerRadius = 14
			textField.leftView = UIView(
				frame: CGRect(x: 0, y: 0, width: 16, height: 0)
			)
			textField.leftViewMode = .always

			addSubview(self.label)
			addSubview(textField)

			NSLayoutConstraint.activate([
				self.label.topAnchor.constraint(equalTo: topAnchor),
				self.label.leadingAnchor.constraint(equalTo: leadingAnchor),
				self.label.trailingAnchor.constraint(equalTo: trailingAnchor),

				textField.topAnchor.constraint(
					equalTo: self.label.bottomAnchor,
					constant: 8
				),
				textField.leadingAnchor.constraint(equalTo: leadingAnchor),
				textField.trailingAnchor.constraint(equalTo: trailingAnchor),
				textField.heightAnchor.constraint(equalToConstant: 48),
				textField.bottomAnchor.constraint(equalTo: bottomAnchor),
			])
		}

		deinit {
			print("deinit FormFieldView: \(label)")
		}
	}

	let firstName = FormFieldView(
		label: "First name",
		placeholder: "Enter your first name"
	)
	let lastName = FormFieldView(
		label: "Last name",
		placeholder: "Enter your last name"
	)
	let nationalId = FormFieldView(
		label: "National ID number",
		placeholder: "Enter your national ID"
	)

	override func viewWillAppear(_ animated: Bool) {
		print("sttg: \(#function) - onBeforeMount")
	}

	override func viewDidAppear(_ animated: Bool) {
		print("sttg: \(#function) - onAfterTransition")
	}

	override func viewDidLoad() {
		print("sttg: \(#function) - setup")  // v-if=toggle если будет освобождать память то при вызове сработает снова

		super.viewDidLoad()
		view.backgroundColor = .white
		title = "Настройки"

		view.addSubview(routerLink)
		view.addSubview(firstName)
		view.addSubview(lastName)
		view.addSubview(nationalId)

		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		NSLayoutConstraint.activate([
			// firstName
			firstName.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 0
			),
			firstName.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			firstName.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),

			// lastName
			lastName.topAnchor.constraint(
				equalTo: firstName.bottomAnchor,
				constant: 16
			),
			lastName.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			lastName.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),

			// nationalId
			nationalId.topAnchor.constraint(
				equalTo: lastName.bottomAnchor,
				constant: 16
			),
			nationalId.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			nationalId.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),

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
