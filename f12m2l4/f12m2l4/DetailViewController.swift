// by mioe

import UIKit

class DetailViewController: UIViewController {
	var post: Post

	lazy var routerPop: UIAction = UIAction { [weak self] _ in
		self?.navigationController?.popViewController(animated: true)
	}

	lazy var preview: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false

		let picture: UIImageView = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.image = post.image
			$0.contentMode = .scaleAspectFill
			$0.clipsToBounds = true
			$0.layer.cornerRadius = 26
			$0.heightAnchor.constraint(equalToConstant: 304).isActive = true
			return $0
		}(UIImageView())

		let routerPopBtn: UIButton = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.backgroundColor = .white
			$0.widthAnchor.constraint(equalToConstant: 40).isActive = true
			$0.heightAnchor.constraint(equalToConstant: 40).isActive = true
			$0.clipsToBounds = true
			$0.layer.cornerRadius = 20

			let icon: UIImageView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.image = .image5
				$0.tintColor = .sTextColorPrimary
				$0.widthAnchor.constraint(equalToConstant: 20).isActive = true
				$0.heightAnchor.constraint(equalToConstant: 20).isActive = true
				$0.transform = CGAffineTransform(rotationAngle: .pi)
				return $0
			}(UIImageView())

			$0.addSubview(icon)

			NSLayoutConstraint.activate([
				icon.centerXAnchor.constraint(equalTo: $0.centerXAnchor, constant: 0),
				icon.centerYAnchor.constraint(equalTo: $0.centerYAnchor, constant: 0),
			])

			return $0
		}(UIButton(primaryAction: routerPop))

		let label: UIView = {
			$0.translatesAutoresizingMaskIntoConstraints = false

			let title: UILabel = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.text = post.title
				$0.font = .systemFont(ofSize: 18, weight: .bold)
				return $0
			}(UILabel())

			let subtitle: UILabel = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.text = post.subtitle
				$0.font = .systemFont(ofSize: 12)
				return $0
			}(UILabel())

			[title, subtitle].forEach { $0.textColor = .white }

			$0.addSubview(title)
			$0.addSubview(subtitle)

			NSLayoutConstraint.activate([
				// экспериментирую строю от обратного

				// subtitle
				subtitle.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 0),
				subtitle.leadingAnchor.constraint(
					equalTo: $0.leadingAnchor,
					constant: 0
				),
				subtitle.trailingAnchor.constraint(
					equalTo: $0.trailingAnchor,
					constant: 0
				),

				// title
				title.bottomAnchor.constraint(
					equalTo: subtitle.topAnchor,
					constant: -4
				),
				title.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
			])

			if post.favorite {
				let heart: UIView = {
					$0.translatesAutoresizingMaskIntoConstraints = false
					$0.backgroundColor = .white
					$0.widthAnchor.constraint(equalToConstant: 32).isActive = true
					$0.heightAnchor.constraint(equalToConstant: 32).isActive = true
					$0.clipsToBounds = true
					$0.layer.cornerRadius = 16

					let icon: UIImageView = {
						$0.translatesAutoresizingMaskIntoConstraints = false
						$0.image = .image7
						$0.widthAnchor.constraint(equalToConstant: 16).isActive = true
						$0.heightAnchor.constraint(equalToConstant: 16).isActive = true
						return $0
					}(UIImageView())

					$0.addSubview(icon)

					NSLayoutConstraint.activate([
						// icon
						icon.centerXAnchor.constraint(
							equalTo: $0.centerXAnchor,
							constant: 0
						),
						icon.centerYAnchor.constraint(
							equalTo: $0.centerYAnchor,
							constant: 1
						),
					])

					return $0
				}(UIView())

				$0.addSubview(heart)

				NSLayoutConstraint.activate([
					// heart
					heart.topAnchor.constraint(equalTo: title.topAnchor, constant: 0),
					heart.trailingAnchor.constraint(
						equalTo: $0.trailingAnchor,
						constant: 0
					),
				])
			}

			return $0
		}(UIView())

		$0.addSubview(picture)
		$0.addSubview(routerPopBtn)
		$0.addSubview(label)

		NSLayoutConstraint.activate([
			// picture
			picture.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
			picture.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
			picture.trailingAnchor.constraint(
				equalTo: $0.trailingAnchor,
				constant: 0
			),
			picture.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 0),

			// routerPopBtn
			routerPopBtn.topAnchor.constraint(equalTo: $0.topAnchor, constant: 16),
			routerPopBtn.leadingAnchor.constraint(
				equalTo: $0.leadingAnchor,
				constant: 16
			),

			// label
			label.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -32),
			label.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 16),
			label.trailingAnchor.constraint(
				equalTo: $0.trailingAnchor,
				constant: -16
			),
		])

		return $0
	}(UIView())

	init(_ post: Post) {
		self.post = post
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.hidesBackButton = true

		let overview: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.text = "Overview"
			$0.font = .systemFont(ofSize: 18, weight: .bold)
			$0.textColor = .sTextColorPrimary
			return $0
		}(UILabel())

		let lorem: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.text = """
				Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
				"""
			$0.numberOfLines = 0
			$0.font = .systemFont(ofSize: 12)
			$0.textColor = .sTextColorSecondary
			return $0
		}(UILabel())
		
		let bookNowBtn: UIButton = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.backgroundColor = .sTextColorPrimary
			$0.setTitle("Book Now", for: .normal)
			$0.setTitleColor(.white, for: .normal)
			$0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
			$0.heightAnchor.constraint(equalToConstant: 60).isActive = true
			$0.layer.cornerRadius = 20
			return $0
		}(UIButton(primaryAction: routerPop))

		view.addSubview(preview)
		view.addSubview(overview)
		view.addSubview(lorem)
		view.addSubview(bookNowBtn)

		NSLayoutConstraint.activate([
			// preview
			preview.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 0
			),
			preview.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			preview.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			
			// overview
			overview.topAnchor.constraint(
				equalTo: preview.bottomAnchor,
				constant: 26
			),
			overview.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			overview.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			
			// lorem
			lorem.topAnchor.constraint(
				equalTo: overview.bottomAnchor,
				constant: 6
			),
			lorem.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			lorem.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			
			// bookNowBtn
			bookNowBtn.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -32
			),
			bookNowBtn.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			bookNowBtn.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
		])
	}

	deinit {
		print("deinit DetailViewController")
	}
}
