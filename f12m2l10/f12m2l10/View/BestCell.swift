// by mioe

import UIKit

class BestCell: UICollectionViewCell {
	
	static let cellId = "BestCell"
	
	private lazy var iconView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.widthAnchor.constraint(equalToConstant: contentView.bounds.height - 16).isActive = true
		$0.heightAnchor.constraint(equalToConstant: contentView.bounds.height - 16).isActive = true
		return $0
	}(UIImageView())
	
	private lazy var fullNameView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 14, weight: .medium)
		return $0
	}(UILabel())
	
	private lazy var descriptionView : UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 12)
		$0.textColor = .secondaryLabel
		$0.numberOfLines = 0
		return $0
	}(UILabel())
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	func setup(entity: AppStoreModel) {
		contentView.subviews.forEach { $0.removeFromSuperview() }
		
		iconView.image = UIImage(named: entity.icon)
		fullNameView.text = entity.fullName
		descriptionView.text = entity.description
		
		self.backgroundColor = .systemGray6
		self.layer.cornerRadius = 20
		self.clipsToBounds = true
		
		contentView.addSubview(iconView)
		contentView.addSubview(fullNameView)
		contentView.addSubview(descriptionView)
		
		NSLayoutConstraint.activate([
			iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			
			fullNameView.topAnchor.constraint(equalTo: iconView.topAnchor, constant: 2),
			fullNameView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 8),
			fullNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			
			descriptionView.topAnchor.constraint(equalTo: fullNameView.bottomAnchor, constant: 4),
			descriptionView.leadingAnchor.constraint(equalTo: fullNameView.leadingAnchor),
			descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
