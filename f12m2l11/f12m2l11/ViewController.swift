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

	lazy var bodyStackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray6
		$0.axis = .vertical  // flex-col
		$0.spacing = 16  // gap-[16px]
		$0.alignment = .fill
		$0.distribution = .fill // justify-start (контент прижат к началу)
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
			$0.widthAnchor.constraint(equalToConstant: 44).isActive = true
			return $0
		}(UIButton())

		$0.addArrangedSubview(avatarStackView)
		$0.addArrangedSubview(buttonView)

		return $0
	}(UIStackView())

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		bodyStackView.addArrangedSubview(bodySection1StackView)

		view.addSubview(scrollView)
		scrollView.addSubview(bodyStackView)

		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor
			),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			bodyStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			bodyStackView.leadingAnchor.constraint(
				equalTo: scrollView.leadingAnchor,
				constant: 32
			),
			bodyStackView.trailingAnchor.constraint(
				equalTo: scrollView.trailingAnchor,
				constant: -32
			),
			bodyStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

			bodyStackView.widthAnchor.constraint(
				equalTo: scrollView.widthAnchor,
				constant: -64
			),
		])
	}
}
