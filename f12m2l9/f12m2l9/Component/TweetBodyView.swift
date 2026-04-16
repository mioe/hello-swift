// by mioe

import UIKit

class TweetBodyView: UIView {

	private let text: String
	private let media: [String]
	private let visualType: TweetVisualType

	lazy var stackWrapperView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.axis = .vertical
		$0.spacing = 8
		return $0
	}(UIStackView())

	lazy var textView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 14)
		$0.numberOfLines = 0
		return $0
	}(UILabel())

	init(
		text: String,
		media: [String],
		visualType: TweetVisualType
	) {
		self.text = text
		self.media = media
		self.visualType = visualType
		super.init(frame: .zero)
		self.setup()
	}

	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false

		textView.text = self.text

		self.addSubview(stackWrapperView)
		stackWrapperView.addArrangedSubview(textView)

		if !media.isEmpty {
			let stackMediaView: UIStackView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.axis = visualType == .collection ? .horizontal : .vertical
				$0.spacing = 4
				$0.layer.cornerRadius = 8
				$0.clipsToBounds = true
				return $0
			}(UIStackView())

			media.forEach {
				let imageView: UIImageView = {
					$0.translatesAutoresizingMaskIntoConstraints = false
					$0.contentMode = .scaleAspectFill
					return $0
				}(UIImageView())
				imageView.image = UIImage(named: $0)

				if let image = imageView.image {
					let aspectRatio = image.size.height / image.size.width
					imageView.heightAnchor.constraint(
						equalTo: imageView.widthAnchor,
						multiplier: aspectRatio
					).isActive = true
				}

				stackMediaView.addArrangedSubview(imageView)
			}

			stackWrapperView.addArrangedSubview(stackMediaView)
		}

		NSLayoutConstraint.activate([
			stackWrapperView.topAnchor.constraint(equalTo: self.topAnchor),
			stackWrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stackWrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			stackWrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
