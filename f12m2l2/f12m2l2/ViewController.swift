// by mioe

import UIKit

class ViewController: UIViewController {
	let hField: CGFloat = 44
	let xPadding = 16

	lazy var emailField = initField(placeholder: "Email", type: .email)
	lazy var passwordField = initField(placeholder: "Password", type: .password)
	lazy var topicField = initField(placeholder: "Topic", type: .text)

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		view.backgroundColor = .red

		view.addSubview(emailField)
		view.addSubview(passwordField)
		view.addSubview(topicField)

		//		emailField.heightAnchor.constraint(equalToConstant: hField).isActive = true
		//		emailField.topAnchor.constraint(
		//			equalTo: view.safeAreaLayoutGuide.topAnchor,
		//			constant: 16
		//		).isActive = true
		//		emailField.leadingAnchor.constraint(
		//			equalTo: view.leadingAnchor,
		//			constant: 32
		//		).isActive = true
		//		emailField.trailingAnchor.constraint(
		//			equalTo: view.trailingAnchor,
		//			constant: -32
		//		).isActive = true

		NSLayoutConstraint.activate([
			// emailField
			emailField.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 16
			),
			emailField.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			emailField.trailingAnchor.constraint(
				equalTo: passwordField.leadingAnchor,
				constant: -16
			),
			emailField.heightAnchor.constraint(equalToConstant: hField),

			// passwordField
			passwordField.topAnchor.constraint(equalTo: emailField.topAnchor), // на одном уровне с emailField
			passwordField.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor),  // занимает ровно столько же сколько и emailField
			passwordField.heightAnchor.constraint(equalToConstant: hField),
			
			// topic
			topicField.topAnchor.constraint(
				equalTo: emailField.bottomAnchor,
				constant: 16
			),
			topicField.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			topicField.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			topicField.heightAnchor.constraint(equalToConstant: hField),
		])
	}

	enum FieldType {
		case text
		case email
		case password
	}

	private func initField(placeholder: String, type: FieldType) -> UITextField {
		let field = UITextField()

		// TAMIC ~~ выходит из стэка блоков (css: false = absolute/fixed, true = static)
		field.translatesAutoresizingMaskIntoConstraints = false

		field.placeholder = placeholder
		field.backgroundColor = .white
		field.layer.cornerRadius = hField / 2
		field.leftView = UIView(
			frame: CGRect(x: 0, y: 0, width: xPadding, height: 0)
		)
		field.leftViewMode = .always

		field.rightView = UIView(
			frame: CGRect(x: 0, y: 0, width: xPadding, height: 0)
		)
		field.rightViewMode = .always

		// типичный input с набор свойств
		switch type {
		case .text:
			field.keyboardType = .default
			field.autocorrectionType = .yes

		case .email:
			field.keyboardType = .emailAddress
			field.autocapitalizationType = .none
			field.autocorrectionType = .no
			field.textContentType = .emailAddress

		case .password:
			field.keyboardType = .default
			field.isSecureTextEntry = true
			field.textContentType = .password
			field.autocorrectionType = .no
		}

		return field
	}
}
