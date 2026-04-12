// by mioe

import UIKit

class EntityView: UIView {
	private let item: TableRowModel
	
	// computed
	var getDetail: DetailEnum {
		item.detail
	}
	
	init(item: TableRowModel) {
		self.item = item
		super.init(frame: .zero)
		self.setup()
	}
	
	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		
		let textColor: UIColor = getDetail == .common ? .black : .white
		
		let title: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.text = "\(item.title)"
			$0.font = .systemFont(ofSize: 18, weight: .bold)
			$0.textColor = textColor
			return $0
		}(UILabel())
		
		let subtitle: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.text = "by \(item.subtitle ?? "")"
			$0.font = .systemFont(ofSize: 18, weight: .bold)
			$0.textColor = textColor
			return $0
		}(UILabel())
		
		let image: UIImageView = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.image = UIImage(named: item.image)
			$0.contentMode = .scaleAspectFit
			$0.layer.cornerRadius = 24
			$0.clipsToBounds = true
			$0.widthAnchor.constraint(equalToConstant: 320).isActive = true
			$0.heightAnchor.constraint(equalToConstant: 320).isActive = true
			return $0
		}(UIImageView())
		
		let lorem: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.text = """
				Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
				"""
			$0.numberOfLines = 0
			$0.font = .systemFont(ofSize: 14)
			$0.textColor = textColor
			return $0
		}(UILabel())
		
		// css flex
		let stack: UIStackView = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.axis = .vertical
			$0.spacing = 8
			return $0
		}(UIStackView())
		
		stack.addArrangedSubview(image)
		stack.addArrangedSubview(title)
		stack.addArrangedSubview(lorem)
		stack.addArrangedSubview(subtitle)
		
		self.addSubview(stack)
		
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
			stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
