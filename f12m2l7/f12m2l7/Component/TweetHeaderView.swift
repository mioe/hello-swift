// by mioe

import UIKit

class TweetHeaderView: UIView {

	private let username: String
	private let nickname: String
	private let postCreatedAt: Date

	init(_ username: String, _ nickname: String, _ postCreatedAt: Date) {
		self.username = username
		self.nickname = nickname
		self.postCreatedAt = postCreatedAt
		super.init(frame: .zero)
		self.setup()
	}

	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false

		let usernameLabel: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.font = .systemFont(ofSize: 12, weight: .semibold)
			$0.text = self.username
			return $0
		}(UILabel())

		let nicknameLabel: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.font = .systemFont(ofSize: 10)
			$0.textColor = .systemGray
			$0.text = "@" + self.nickname
			return $0
		}(UILabel())

		let createdAtLabel: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.font = .systemFont(ofSize: 10)
			$0.textColor = .systemGray
			return $0
		}(UILabel())
		createdAtLabel.text = Self.relativeDate(from: self.postCreatedAt)

		self.addSubview(usernameLabel)
		self.addSubview(nicknameLabel)
		self.addSubview(createdAtLabel)

		NSLayoutConstraint.activate([
			// usernameLabel
			usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			usernameLabel.leadingAnchor.constraint(
				equalTo: self.leadingAnchor,
				constant: 0
			),
			usernameLabel.bottomAnchor.constraint(
				equalTo: self.bottomAnchor,
				constant: 0
			),

			// nicknameLabel
			nicknameLabel.leadingAnchor.constraint(
				equalTo: usernameLabel.trailingAnchor,
				constant: 8
			),
			nicknameLabel.centerYAnchor.constraint(
				equalTo: usernameLabel.centerYAnchor
			),

			// createdAtLabel
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
