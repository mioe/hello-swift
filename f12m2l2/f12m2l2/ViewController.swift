// by mioe

import UIKit

class ViewController: UIViewController {
	let hField: CGFloat = 44
	let xPadding: CGFloat = 16
	lazy var rounded: CGFloat = hField / 2

	lazy var emailField = initField(placeholder: "Email", type: .email)
	lazy var passwordField = initField(placeholder: "Password", type: .password)
	lazy var topicField = initField(placeholder: "Тема", type: .text)

	lazy var picture: UIImageView = {
		let pictureView = UIImageView()
		pictureView.translatesAutoresizingMaskIntoConstraints = false
		pictureView.image = .homemac
		pictureView.contentMode = .scaleAspectFit
		pictureView.clipsToBounds = true
		pictureView.layer.cornerRadius = rounded * 1.5
		return pictureView
	}()

	lazy var bg: UIImageView = {
		let pictureView = UIImageView()
		pictureView.translatesAutoresizingMaskIntoConstraints = false
		pictureView.image = .homemac
		pictureView.contentMode = .scaleAspectFill
		pictureView.clipsToBounds = true

		// blur поверх картинки
		let blur = UIVisualEffectView(
			effect: UIBlurEffect(style: .systemUltraThinMaterial)
		)
		blur.frame = pictureView.bounds
		blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]  // растягивается вместе с pictureView
		pictureView.addSubview(blur)

		return pictureView
	}()

	lazy var label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Сообщение"
		label.font = .systemFont(ofSize: 24, weight: .medium)
		return label
	}()

	lazy var textarea: UIView = {
		let group = UIView()
		group.translatesAutoresizingMaskIntoConstraints = false

		let wrapper = UIView()
		wrapper.translatesAutoresizingMaskIntoConstraints = false
		wrapper.backgroundColor = .white
		wrapper.layer.cornerRadius = rounded * 1.5
		wrapper.clipsToBounds = true

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Содержимое"
		label.font = .systemFont(ofSize: 14, weight: .regular)

		let textarea = UITextView()
		textarea.translatesAutoresizingMaskIntoConstraints = false
		textarea.font = .systemFont(ofSize: 18, weight: .regular)

		group.addSubview(label)
		wrapper.addSubview(textarea)
		group.addSubview(wrapper)

		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: group.topAnchor),
			label.leadingAnchor.constraint(
				equalTo: group.leadingAnchor,
				constant: 16
			),

			wrapper.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
			wrapper.leadingAnchor.constraint(equalTo: group.leadingAnchor),
			wrapper.trailingAnchor.constraint(equalTo: group.trailingAnchor),
			wrapper.bottomAnchor.constraint(equalTo: group.bottomAnchor),

			textarea.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 16),
			textarea.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 16),
			textarea.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -16),
			textarea.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
		])

		return group
	}()

	lazy var button: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Отправить", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .black
		button.layer.cornerRadius = rounded
		button.heightAnchor.constraint(equalToConstant: hField).isActive = true
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		view.addSubview(bg)
		view.addSubview(picture)
		view.addSubview(label)
		view.addSubview(emailField)
		view.addSubview(passwordField)
		view.addSubview(topicField)
		view.addSubview(textarea)
		view.addSubview(button)

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
			// bg
			bg.topAnchor.constraint(equalTo: view.topAnchor),
			bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			bg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bg.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			// picture
			picture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			picture.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			picture.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			picture.heightAnchor.constraint(equalToConstant: hField * 4),

			// label
			label.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 16),
			label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			label.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),

			// emailField
			emailField.topAnchor.constraint(
				equalTo: label.bottomAnchor,
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
			passwordField.topAnchor.constraint(equalTo: emailField.topAnchor),  // на одном уровне с emailField
			passwordField.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor),  // занимает ровно столько же сколько и emailField
			passwordField.heightAnchor.constraint(equalToConstant: hField),

			// topicField
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

			// textarea
			textarea.topAnchor.constraint(
				equalTo: topicField.bottomAnchor,
				constant: 16
			),
			textarea.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			textarea.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			textarea.heightAnchor.constraint(equalToConstant: hField * 4),

			// button
			button.bottomAnchor.constraint(
				equalTo: view.bottomAnchor,
				constant: -32
			),
			button.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			button.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
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
		field.layer.cornerRadius = rounded
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
