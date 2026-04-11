// by mioe

import UIKit

class ViewController: UIViewController {
	let DEBUG: Bool = true

	enum Rounded {
		case sm
		case md
	}

	class ShadowView<T: UIView>: UIView {
		private let slot: T
		private let rounded: Rounded

		var getRoundedValue: CGFloat {
			switch rounded {
			case .sm: return 18
			case .md: return 26
			}
		}

		var getShadowOffetY: CGFloat {
			switch rounded {
			case .sm: return 12
			case .md: return 24
			}
		}

		init(_ slot: T, rounded: Rounded = .sm) {
			self.slot = slot
			self.rounded = rounded
			super.init(frame: .zero)
			setup()
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		private func setup() {
			translatesAutoresizingMaskIntoConstraints = false
			slot.translatesAutoresizingMaskIntoConstraints = false

			slot.layer.cornerRadius = getRoundedValue

			self.layer.shadowColor = UIColor.black.cgColor
			self.layer.shadowOpacity = 0.12
			self.layer.shadowOffset = CGSize(width: 0, height: getShadowOffetY)  // into figma: X: 0, Y: 24
			self.layer.shadowRadius = 42  // 84 / 2
			self.layer.cornerRadius = getRoundedValue

			self.addSubview(slot)

			NSLayoutConstraint.activate([
				slot.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
				slot.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
				slot.trailingAnchor.constraint(
					equalTo: self.trailingAnchor,
					constant: 0
				),
				slot.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
			])
		}

		deinit {
			print("deinit ShadowView")
		}
	}
	
	class Header: UIView {
		private let title: String
		private let debug: Bool
		
		init(_ title: String, debug: Bool = false) {
			self.title = title
			self.debug = debug
			super.init(frame: .zero)
			setup()
		}
		
		private func setup() {
			translatesAutoresizingMaskIntoConstraints = false
			
			if debug { self.backgroundColor = .systemGray6 }
			
			let title = UILabel()
			title.translatesAutoresizingMaskIntoConstraints = false
			
			title.text = self.title
			title.font = .systemFont(ofSize: 18, weight: .bold)
			title.textColor = .sTextColorPrimary
			
			let btn = UIButton()
			btn.translatesAutoresizingMaskIntoConstraints = false
			
			btn.setTitle("see all", for: .normal)
			btn.setTitleColor(.sTextColorSecondary, for: .normal)
			btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
			
			self.addSubview(title)
			self.addSubview(btn)
			
			NSLayoutConstraint.activate([
				// title
				title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
				title.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
				title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
				
				// btn
				btn.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
				btn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
			])
		}
		
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		deinit {
			print("deinit Header")
		}
	}

	lazy var welcome: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		if DEBUG { $0.backgroundColor = .systemGray6 }

		let ava = UIImageView(image: .IMG_9172_2)
		ava.translatesAutoresizingMaskIntoConstraints = false

		ava.heightAnchor.constraint(equalToConstant: 42).isActive = true
		ava.widthAnchor.constraint(equalToConstant: 42).isActive = true
		ava.clipsToBounds = true
		ava.contentMode = .scaleAspectFill
		ava.layer.cornerRadius = 18

		let group = UIView()
		group.translatesAutoresizingMaskIntoConstraints = false

		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false

		label.text = "welcome"
		label.font = .systemFont(ofSize: 12)
		label.textColor = .sTextColorSecondary

		let username = UILabel()
		username.translatesAutoresizingMaskIntoConstraints = false

		username.text = "Misha"
		username.font = .systemFont(ofSize: 16, weight: .bold)
		username.textColor = .sTextColorPrimary

		group.addSubview(label)
		group.addSubview(username)

		NSLayoutConstraint.activate([
			// label
			label.topAnchor.constraint(equalTo: group.topAnchor),
			label.leadingAnchor.constraint(equalTo: group.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: group.trailingAnchor),

			// username
			username.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
			username.leadingAnchor.constraint(equalTo: group.leadingAnchor),
			username.bottomAnchor.constraint(equalTo: group.bottomAnchor),
		])

		let notify = UIImageView(image: .image3)
		notify.translatesAutoresizingMaskIntoConstraints = false
		notify.tintColor = .sTextColorSecondary
		notify.heightAnchor.constraint(equalToConstant: 20).isActive = true
		notify.widthAnchor.constraint(equalToConstant: 20).isActive = true

		$0.addSubview(ava)
		$0.addSubview(group)
		$0.addSubview(notify)

		NSLayoutConstraint.activate([
			// ava
			ava.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
			ava.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
			ava.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 0),

			// group
			group.centerYAnchor.constraint(equalTo: ava.centerYAnchor, constant: 0),
			group.leadingAnchor.constraint(equalTo: ava.trailingAnchor, constant: 16),

			// notify
			notify.trailingAnchor.constraint(
				equalTo: $0.trailingAnchor,
				constant: -6
			),
			notify.centerYAnchor.constraint(equalTo: ava.centerYAnchor, constant: 0),
		])
		return $0
	}(UIView())

	lazy var search: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		if DEBUG { $0.backgroundColor = .systemGray6 }

		let hSearchEl: CGFloat = 50

		let field = UITextField()
		let shadowField = ShadowView(field)

		field.placeholder = "search your trip ..."
		field.leftView = UIView(
			frame: CGRect(x: 0, y: 0, width: 16, height: 0)
		)
		field.leftViewMode = .always
		field.rightView = UIView(
			frame: CGRect(x: 0, y: 0, width: 16, height: 0)
		)
		field.rightViewMode = .always
		field.heightAnchor.constraint(equalToConstant: hSearchEl).isActive = true
		field.backgroundColor = .white

		let icon = UIImageView()
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.image = .image4
		icon.tintColor = .white
		icon.contentMode = .scaleAspectFit
		icon.widthAnchor.constraint(equalToConstant: 16).isActive = true
		icon.heightAnchor.constraint(equalToConstant: 16).isActive = true

		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.backgroundColor = .sTextColorPrimary
		btn.widthAnchor.constraint(equalToConstant: 48).isActive = true
		btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
		btn.layer.cornerRadius = 18

		btn.addSubview(icon)

		NSLayoutConstraint.activate([
			icon.centerXAnchor.constraint(equalTo: btn.centerXAnchor, constant: 0),
			icon.centerYAnchor.constraint(equalTo: btn.centerYAnchor, constant: 0),
		])

		$0.addSubview(shadowField)
		$0.addSubview(btn)

		NSLayoutConstraint.activate([
			// shadowField
			shadowField.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
			shadowField.leadingAnchor.constraint(
				equalTo: $0.leadingAnchor,
				constant: 0
			),
			shadowField.bottomAnchor.constraint(
				equalTo: $0.bottomAnchor,
				constant: 0
			),
			shadowField.trailingAnchor.constraint(
				equalTo: btn.leadingAnchor,
				constant: -16
			),
			// btn
			btn.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
			btn.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 0),
			btn.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 0),
		])

		return $0
	}(UIView())

	lazy var popularTrip: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		if DEBUG { $0.backgroundColor = .systemGray5 }

		let header = Header("Popular Category", debug: DEBUG)

		let card: UIButton = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.backgroundColor = .white

			let picture: UIView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.heightAnchor.constraint(equalToConstant: 142).isActive = true

				let picture = UIImageView()
				picture.translatesAutoresizingMaskIntoConstraints = false
				picture.image = .image6
				picture.contentMode = .scaleAspectFill
				picture.clipsToBounds = true
				picture.layer.cornerRadius = 26
				
				let icon = UIImageView()
				icon.translatesAutoresizingMaskIntoConstraints = false
				icon.image = .image7
				icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
				icon.widthAnchor.constraint(equalToConstant: 24).isActive = true

				$0.addSubview(picture)
				$0.addSubview(icon)

				NSLayoutConstraint.activate([
					// picture
					picture.topAnchor.constraint(equalTo: $0.topAnchor, constant: 12),
					picture.leadingAnchor.constraint(
						equalTo: $0.leadingAnchor,
						constant: 12
					),
					picture.trailingAnchor.constraint(
						equalTo: $0.trailingAnchor,
						constant: -12
					),
					picture.bottomAnchor.constraint(
						equalTo: $0.bottomAnchor,
						constant: 0
					),
					
					// icon
					icon.topAnchor.constraint(equalTo: picture.topAnchor, constant: 14),
					icon.trailingAnchor.constraint(equalTo: picture.trailingAnchor, constant: -14),
				])

				return $0
			}(UIView())
			
			let label: UIView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				
				let title: UILabel = {
					$0.translatesAutoresizingMaskIntoConstraints = false
					$0.text = "Greenland"
					$0.font = .systemFont(ofSize: 18, weight: .bold)
					$0.textColor = .sTextColorPrimary
					return $0
				}(UILabel())
				
				let subtitle: UILabel = {
					$0.translatesAutoresizingMaskIntoConstraints = false
					$0.text = "Greenland, North"
					$0.font = .systemFont(ofSize: 12)
					$0.textColor = .sTextColorSecondary
					return $0
				}(UILabel())
				
				let icon: UIImageView = {
					$0.translatesAutoresizingMaskIntoConstraints = false
					$0.image = .image5
					$0.tintColor = .sTextColorPrimary
					$0.heightAnchor.constraint(equalToConstant: 20).isActive = true
					$0.widthAnchor.constraint(equalToConstant: 20).isActive = true
					return $0
				}(UIImageView())
				
				$0.addSubview(title)
				$0.addSubview(subtitle)
				$0.addSubview(icon)
				
				NSLayoutConstraint.activate([
					// title
					title.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
					title.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
					
					// subtitle
					subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
					subtitle.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
					subtitle.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 0),
					
					// icon
					icon.topAnchor.constraint(equalTo: title.topAnchor, constant: 0),
					icon.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 0),
				])
				
				return $0
			}(UIView())
			
			$0.addSubview(picture)
			$0.addSubview(label)

			NSLayoutConstraint.activate([
				// picture
				picture.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
				picture.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
				picture.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 0),
				
				// label
				label.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 14),
				label.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 24),
				label.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -24),
				label.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -24),
			])

			return $0
		}(UIButton())
		let shadowCard = ShadowView(card, rounded: .md)

		$0.addSubview(header)
		$0.addSubview(shadowCard)

		NSLayoutConstraint.activate([
			// header
			header.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
			header.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
			header.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 0),

			// shadowCard
			shadowCard.topAnchor.constraint(
				equalTo: header.bottomAnchor,
				constant: 16
			),
			shadowCard.leadingAnchor.constraint(
				equalTo: $0.leadingAnchor,
				constant: 0
			),
			shadowCard.trailingAnchor.constraint(
				equalTo: $0.trailingAnchor,
				constant: 0
			),
			shadowCard.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 0),
		])

		return $0
	}(UIView())
	
	lazy var popularCategory: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		if DEBUG { $0.backgroundColor = .systemGray5 }
		
		let header = Header("Popular Trip", debug: DEBUG)
		
		$0.addSubview(header)
		
		NSLayoutConstraint.activate([
			// header
			header.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
			header.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
			header.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 0),
		])
		
		return $0
	}(UIView())

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		view.addSubview(welcome)
		view.addSubview(search)
		view.addSubview(popularTrip)
		view.addSubview(popularCategory)

		NSLayoutConstraint.activate([
			// welcome
			welcome.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 0
			),
			welcome.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			welcome.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),

			// search
			search.topAnchor.constraint(equalTo: welcome.bottomAnchor, constant: 48),
			search.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			search.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),

			// popularTrip
			popularTrip.topAnchor.constraint(
				equalTo: search.bottomAnchor,
				constant: 48
			),
			popularTrip.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			popularTrip.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			
			// popularCategory
			popularCategory.topAnchor.constraint(
				equalTo: popularTrip.bottomAnchor,
				constant: 48
			),
			popularCategory.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			popularCategory.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
		])
	}
}
