// by mioe

import UIKit

class TweetBodyView: UIView {

	private let text: String
	private let media: [String: TweetMediaType]
	private let bodyType: TweetBodyType

	init(
		_ text: String,
		_ media: [String: TweetMediaType],
		_ bodyType: TweetBodyType
	) {
		self.text = text
		self.media = media
		self.bodyType = bodyType
		super.init(frame: .zero)
		self.setup()
	}

	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false

		lazy var textView: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.font = .systemFont(ofSize: 14)
			$0.numberOfLines = 0
			return $0
		}(UILabel())

		textView.text = self.text
		self.addSubview(textView)

		NSLayoutConstraint.activate([
			// textView
			textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			textView.leadingAnchor.constraint(
				equalTo: self.leadingAnchor,
				constant: 0
			),
			textView.trailingAnchor.constraint(
				equalTo: self.trailingAnchor,
				constant: 0
			),
		])

		if !media.isEmpty {
			lazy var stackView: UIStackView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.axis = .horizontal
				$0.spacing = 8
				$0.layer.cornerRadius = 8
				$0.clipsToBounds = true
				return $0
			}(UIStackView())

			print(media)

			media.forEach {
				if $0.value == .image {
					let imageView: UIImageView = {
						$0.translatesAutoresizingMaskIntoConstraints = false
						$0.contentMode = .scaleAspectFill
						return $0
					}(UIImageView())
					imageView.image = UIImage(named: $0.key)

					if let image = imageView.image {
						let aspectRatio = image.size.height / image.size.width
						imageView.heightAnchor.constraint(
							equalTo: imageView.widthAnchor,
							multiplier: aspectRatio
						).isActive = true
					}

					stackView.addArrangedSubview(imageView)

				} else if $0.value == .video {

				}
			}

			self.addSubview(stackView)

			NSLayoutConstraint.activate([
				// stackView
				stackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
				stackView.leadingAnchor.constraint(
					equalTo: self.leadingAnchor,
					constant: 0
				),
				stackView.trailingAnchor.constraint(
					equalTo: self.trailingAnchor,
					constant: 0
				),
				stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
			])
		} else {
			NSLayoutConstraint.activate([
				// textView
				textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
			])
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
