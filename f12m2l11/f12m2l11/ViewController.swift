// by mioe

import UIKit

class ViewController: UIViewController {

	lazy var scrollView: UIScrollView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray5
		$0.showsVerticalScrollIndicator = false
		$0.showsHorizontalScrollIndicator = false
		return $0
	}(UIScrollView())

	lazy var mainStackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .red
		$0.axis = .vertical  // flex-col
		$0.spacing = 32  // gap-[32px]
		$0.alignment = .fill
		$0.distribution = .fill  // justify-start (контент прижат к началу)
		return $0
	}(UIStackView())

	lazy var bodyStackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemTeal
		$0.axis = .vertical
		$0.spacing = 16
		$0.alignment = .fill
		$0.distribution = .fill
		return $0
	}(UIStackView())

	lazy var bodySection1StackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray6
		$0.axis = .horizontal
		$0.spacing = 16
		$0.alignment = .center
		$0.distribution = .fill

		let avatarStackView: UIStackView = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.axis = .horizontal  // flex-row
			$0.spacing = 8
			$0.alignment = .center

			let avatarImageView: UIImageView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.widthAnchor.constraint(equalToConstant: 64).isActive = true
				$0.heightAnchor.constraint(equalToConstant: 64).isActive = true
				$0.layer.cornerRadius = 32
				$0.clipsToBounds = true
				return $0
			}(UIImageView())

			let nameLabelView: UILabel = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.backgroundColor = .systemGray4
				$0.font = .systemFont(ofSize: 16, weight: .bold)
				return $0
			}(UILabel())

			avatarImageView.image = ._1775640178368
			nameLabelView.text = "misha gezha"

			$0.addArrangedSubview(avatarImageView)
			$0.addArrangedSubview(nameLabelView)

			return $0
		}(UIStackView())

		let buttonView: UIButton = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.backgroundColor = .systemGray4
			$0.setImage(UIImage(systemName: "gear"), for: .normal)
			$0.widthAnchor.constraint(equalToConstant: 24).isActive = true
			return $0
		}(UIButton())

		$0.addArrangedSubview(avatarStackView)
		$0.addArrangedSubview(buttonView)

		return $0
	}(UIStackView())

	lazy var bodySection2StackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray6
		$0.axis = .horizontal
		$0.alignment = .center
		$0.distribution = .equalCentering
		return $0
	}(UIStackView())

	lazy var bodySection3TextView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray6
		$0.numberOfLines = 0
		$0.font = .systemFont(ofSize: 14)
		return $0
	}(UILabel())

	lazy var photosStackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemTeal
		$0.axis = .vertical
		$0.spacing = 16
		$0.alignment = .fill
		$0.distribution = .fill
		return $0
	}(UIStackView())
	
	lazy var photosSection1LabelView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray4
		$0.font = .systemFont(ofSize: 16, weight: .bold)
		$0.text = "Photos"
		return $0
	}(UILabel())
	
	lazy var photosSection2StackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray6
		$0.axis = .horizontal
		$0.spacing = 16
		$0.distribution = .fillEqually
		return $0
	}(UIStackView())

	lazy var footerStackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemTeal
		$0.axis = .vertical
		$0.spacing = 16
		$0.alignment = .fill
		$0.distribution = .fill
		return $0
	}(UIStackView())

	lazy var footerSection1StackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray6
		$0.axis = .horizontal
		$0.spacing = 16
		$0.alignment = .center
		$0.distribution = .fill

		let labelView: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.backgroundColor = .systemGray4
			$0.font = .systemFont(ofSize: 16, weight: .bold)
			return $0
		}(UILabel())
		labelView.text = "Description"

		let buttonView: UIButton = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.backgroundColor = .systemGray4
			$0.setTitle("See all", for: .normal)
			$0.setTitleColor(.systemBlue, for: .normal)
			$0.widthAnchor.constraint(equalToConstant: 60).isActive = true
			return $0
		}(UIButton())

		$0.addArrangedSubview(labelView)
		$0.addArrangedSubview(buttonView)

		return $0
	}(UIStackView())
	
	lazy var footerSection2TextView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray6
		$0.numberOfLines = 0
		$0.font = .systemFont(ofSize: 14)
		return $0
	}(UILabel())

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		[
			UIImage(named: "chihiro043"), UIImage(named: "homemac"),
			UIImage(named: "mf"), UIImage(named: "zelda-totk"),
		].forEach {
			let imageView = UIImageView()
			imageView.translatesAutoresizingMaskIntoConstraints = false
			imageView.image = $0
			imageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
			imageView.widthAnchor.constraint(equalToConstant: 72).isActive = true
			imageView.layer.cornerRadius = 8
			imageView.clipsToBounds = true
			imageView.contentMode = .scaleAspectFill
			bodySection2StackView.addArrangedSubview(imageView)
		}

		bodySection3TextView.text = """
			Специализируюсь на Vue3/Astro, TypeScript, Nest/Hono и PostgreSQL. Строю продукты с нуля и масштабирую существующие: от архитектуры фронтенда до CI/CD и биллинговых систем. Умею нанимать, менторить и растить разработчиков внутри команды.
				
			В свободное время слежу за новостями в мире IT, изучаю новые технологии и пробую применять их в личных проектах.
				
			🐥🐥🐤
			"""
		
		[UIImage(named: "chihiro043"), UIImage(named: "homemac")].forEach {
			let imageView = UIImageView()
			imageView.translatesAutoresizingMaskIntoConstraints = false
			imageView.image = $0
			imageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
			imageView.layer.cornerRadius = 8
			imageView.clipsToBounds = true
			imageView.contentMode = .scaleAspectFill
			photosSection2StackView.addArrangedSubview(imageView)
		}
		
		footerSection2TextView.text = """
			Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
			"""

		bodyStackView.addArrangedSubview(bodySection1StackView)
		bodyStackView.addArrangedSubview(bodySection2StackView)
		bodyStackView.addArrangedSubview(bodySection3TextView)
		
		photosStackView.addArrangedSubview(photosSection1LabelView)
		photosStackView.addArrangedSubview(photosSection2StackView)
		
		footerStackView.addArrangedSubview(footerSection1StackView)
		footerStackView.addArrangedSubview(footerSection2TextView)

		mainStackView.addArrangedSubview(bodyStackView)
		mainStackView.addArrangedSubview(photosStackView)
		mainStackView.addArrangedSubview(footerStackView)

		view.addSubview(scrollView)
		scrollView.addSubview(mainStackView)

		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			mainStackView.leadingAnchor.constraint(
				equalTo: scrollView.leadingAnchor,
				constant: 32
			),
			mainStackView.trailingAnchor.constraint(
				equalTo: scrollView.trailingAnchor,
				constant: -32
			),
			mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

			mainStackView.widthAnchor.constraint(
				equalTo: scrollView.widthAnchor,
				constant: -64
			),
		])
	}
}
