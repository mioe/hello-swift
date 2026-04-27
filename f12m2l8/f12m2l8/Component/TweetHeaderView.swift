// by mioe

import UIKit

class TweetHeaderView: UIView {
	
	private let avatar: String
	private let username: String
	private let nickname: String
	private let createdAt: Date
	private let visualType: TweetVisualType
	
	init(avatar: String, username: String, nickname: String, createdAt: Date, visualType: TweetVisualType) {
		self.avatar = avatar
		self.username = username
		self.nickname = nickname
		self.createdAt = createdAt
		self.visualType = visualType
		super.init(frame: .zero)
		self.setup()
	}
	
	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.heightAnchor.constraint(equalToConstant: 40).isActive = true
		self.backgroundColor = .systemBackground
		self.layer.cornerRadius = 20
		
		lazy var avatarView: UIImageView = {
			let size: CGFloat = 32
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.widthAnchor.constraint(equalToConstant: size).isActive = true
			$0.heightAnchor.constraint(equalToConstant: size).isActive = true
			$0.contentMode = .scaleAspectFill
			$0.clipsToBounds = true
			$0.layer.cornerRadius = size / 2
			return $0
		}(UIImageView())
		avatarView.image = UIImage(named: self.avatar)
		
		lazy var usernameLabel: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.font = .systemFont(ofSize: 12, weight: .medium)
			$0.text = self.username
			return $0
		}(UILabel())
		
		lazy var nicknameLabel: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.font = .systemFont(ofSize: 10)
			$0.textColor = .systemGray
			$0.text = "@" + self.nickname
			return $0
		}(UILabel())
		
		self.addSubview(avatarView)
		self.addSubview(usernameLabel)
		self.addSubview(nicknameLabel)
		
		NSLayoutConstraint.activate([
			// avatarView
			avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
			avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
			avatarView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
			
			// usernameLabel
			usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 4),
			usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
			
			// nicknameLabel
			nicknameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2),
			nicknameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor, constant: 0),
			nicknameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
		])
	}
	
	private static func relativeDate(from date: Date) -> String {
		let seconds = Int(Date().timeIntervalSince(date))
		switch seconds {
		case ..<60: return "\(seconds)s"
		case ..<3600: return "\(seconds / 60)m"
		case ..<86400: return "\(seconds / 3600)h"
		case ..<604800: return "\(seconds / 86400)d"
		case ..<2_592_000: return "\(seconds / 604800)w"
		default: return "\(seconds / 2_592_000)mo"
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
