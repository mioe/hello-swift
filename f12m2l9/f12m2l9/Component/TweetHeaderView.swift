// by mioe

import UIKit

class TweetHeaderView: UIView {

	private let username: String
	private let nickname: String
	private let createdAt: Date
	private let visualType: TweetVisualType

	private lazy var usernameLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 12, weight: .semibold)
		return $0
	}(UILabel())

	private lazy var nicknameLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 10)
		$0.textColor = .systemGray
		return $0
	}(UILabel())

	private lazy var createdAtLabel: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.font = .systemFont(ofSize: 10)
		$0.textColor = .systemGray
		return $0
	}(UILabel())

	init(
		username: String,
		nickname: String,
		createdAt: Date,
		visualType: TweetVisualType
	) {
		self.username = username
		self.nickname = nickname
		self.createdAt = createdAt
		self.visualType = visualType
		super.init(frame: .zero)
		self.setup()
	}

	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false

		usernameLabel.text = self.username
		nicknameLabel.text = "@" + self.nickname
		createdAtLabel.text = Self.relativeDate(from: self.createdAt)  // static через Self

		if visualType == .article {
			usernameLabel.textColor = .white
		}

		self.addSubview(usernameLabel)
		self.addSubview(nicknameLabel)
		self.addSubview(createdAtLabel)

		NSLayoutConstraint.activate([
			usernameLabel.topAnchor.constraint(equalTo: self.topAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			usernameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),

			nicknameLabel.leadingAnchor.constraint(
				equalTo: usernameLabel.trailingAnchor,
				constant: 8
			),
			nicknameLabel.centerYAnchor.constraint(
				equalTo: usernameLabel.centerYAnchor
			),

			createdAtLabel.leadingAnchor.constraint(
				equalTo: nicknameLabel.trailingAnchor,
				constant: 8
			),
			createdAtLabel.centerYAnchor.constraint(
				equalTo: usernameLabel.centerYAnchor
			),
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
