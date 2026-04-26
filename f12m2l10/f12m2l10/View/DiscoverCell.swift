// by mioe

import UIKit

class DiscoverCell: UICollectionViewCell {
	
	static let cellId = "DescoverCell"
	
	private lazy var iconView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 8).isActive = true
		$0.heightAnchor.constraint(equalToConstant: contentView.bounds.width - 8).isActive = true
		return $0
	}(UIImageView())
	
	private lazy var shortNameView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 12)
		$0.textAlignment = .center
		return $0
	}(UILabel())
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	func setup(entity: AppStoreModel) {
		contentView.subviews.forEach { $0.removeFromSuperview() }
		
		iconView.image = UIImage(named: entity.icon)
		shortNameView.text = entity.shortName
		
		self.backgroundColor = .systemGray6
		self.layer.cornerRadius = 20
		self.clipsToBounds = true
		
		contentView.addSubview(iconView)
		contentView.addSubview(shortNameView)
		
		NSLayoutConstraint.activate([
			iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
			iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
			
			shortNameView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 2),
			shortNameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
			shortNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
			shortNameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
