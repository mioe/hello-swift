// by mioe

import UIKit

class EssentialCell: UICollectionViewCell {

	static let cellId = "EssentialCell"

	private lazy var previewView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.contentMode = .scaleAspectFill
		$0.clipsToBounds = true
		return $0
	}(UIImageView())

	private lazy var iconView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.widthAnchor.constraint(equalToConstant: 56).isActive = true
		$0.heightAnchor.constraint(equalToConstant: 56).isActive = true
		return $0
	}(UIImageView())

	private lazy var fullNameView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 14, weight: .medium)
		return $0
	}(UILabel())

	private lazy var descriptionView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 12)
		$0.textColor = .secondaryLabel
		$0.numberOfLines = 0
		return $0
	}(UILabel())

	private lazy var blurView: UIVisualEffectView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		return $0
	}(UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial)))

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	private var previewAspectConstraint: NSLayoutConstraint?

	func setup(entity: AppStoreModel) {
		contentView.subviews.forEach { $0.removeFromSuperview() }

		previewView.image = UIImage(named: entity.preview ?? "")
		iconView.image = UIImage(named: entity.icon)
		fullNameView.text = entity.fullName
		descriptionView.text = entity.description

		self.backgroundColor = .systemGray6
		self.layer.cornerRadius = 20
		self.clipsToBounds = true

		contentView.addSubview(previewView)
		contentView.addSubview(blurView)
		contentView.addSubview(iconView)
		contentView.addSubview(fullNameView)
		contentView.addSubview(descriptionView)

		if let prev = previewAspectConstraint {
			previewView.removeConstraint(prev)
		}
		if let image = previewView.image, image.size.width > 0 {
			let ratio = image.size.height / image.size.width
			previewAspectConstraint = previewView.heightAnchor.constraint(
				equalTo: previewView.widthAnchor,
				multiplier: ratio
			)
			previewAspectConstraint?.isActive = true
		}

		NSLayoutConstraint.activate([
			previewView.topAnchor.constraint(equalTo: contentView.topAnchor),
			previewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			previewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			previewView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
			iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			iconView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 12),

			fullNameView.topAnchor.constraint(equalTo: iconView.topAnchor, constant: 2),
			fullNameView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
			fullNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

			descriptionView.topAnchor.constraint(equalTo: fullNameView.bottomAnchor, constant: 4),
			descriptionView.leadingAnchor.constraint(equalTo: fullNameView.leadingAnchor),
			descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
