// by mioe

import AVFoundation
import UIKit

private class PlayerView: UIView {
	override class var layerClass: AnyClass { AVPlayerLayer.self }
	var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}

class TweetBodyView: UIView {

	private let text: String
	private let media: [String: TweetMediaType]
	private let visualType: TweetVisualType

	private var player: AVPlayer?
	private var muteButton: UIButton?
	private var loopObserver: NSObjectProtocol?

	init(
		_ text: String,
		_ media: [String: TweetMediaType],
		_ visualType: TweetVisualType
	) {
		self.text = text
		self.media = media
		self.visualType = visualType
		super.init(frame: .zero)
		self.setup()
	}

	deinit {
		if let observer = loopObserver {
			NotificationCenter.default.removeObserver(observer)
		}
	}

	func play() {
		player?.play()
	}

	func pause() {
		player?.pause()
	}

	var hasVideo: Bool {
		player != nil
	}

	private func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false

		let textView: UILabel = {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.font = .systemFont(ofSize: 14)
			if visualType == .article {
				$0.textColor = .white
			}
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
			let stackView: UIStackView = {
				$0.translatesAutoresizingMaskIntoConstraints = false
				$0.axis = visualType == .card ? .horizontal : .vertical
				$0.spacing = 4
				$0.layer.cornerRadius = 8
				$0.clipsToBounds = true
				return $0
			}(UIStackView())

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
						let c = imageView.heightAnchor.constraint(
							equalTo: imageView.widthAnchor,
							multiplier: aspectRatio
						)
						c.priority = UILayoutPriority(999)
						c.isActive = true
					}

					stackView.addArrangedSubview(imageView)

				} else if $0.value == .video {
					// by claude sonnet 4.6 - все что касается видео
					let mediaKey = $0.key

					guard let videoURL = Bundle.main.url(forResource: mediaKey, withExtension: "mp4") else { return }

					let container = PlayerView()
					container.translatesAutoresizingMaskIntoConstraints = false
					container.backgroundColor = .black

					// Generate thumbnail for aspect ratio
					let asset = AVURLAsset(url: videoURL)
					let imageGenerator = AVAssetImageGenerator(asset: asset)
					imageGenerator.appliesPreferredTrackTransform = true
					let heightConstraint = container.heightAnchor.constraint(
						equalTo: container.widthAnchor,
						multiplier: 16.0 / 9.0 // default, updated async
					)
					heightConstraint.priority = UILayoutPriority(999)
					heightConstraint.isActive = true

					Task { [weak container] in
						if let cgImage = try? await imageGenerator.image(at: .zero).image {
							let thumbImage = UIImage(cgImage: cgImage)
							let aspectRatio = thumbImage.size.height / thumbImage.size.width
							await MainActor.run {
								guard let container = container else { return }
								heightConstraint.isActive = false
								let updated = container.heightAnchor.constraint(
									equalTo: container.widthAnchor,
									multiplier: aspectRatio
								)
								updated.priority = UILayoutPriority(999)
								updated.isActive = true
								container.superview?.layoutIfNeeded()
							}
						}
					}

					// AVPlayer
					let playerItem = AVPlayerItem(asset: asset)
					let avPlayer = AVPlayer(playerItem: playerItem)
					avPlayer.isMuted = true
					self.player = avPlayer

					container.playerLayer.player = avPlayer
					container.playerLayer.videoGravity = .resizeAspectFill

					// Loop video
					loopObserver = NotificationCenter.default.addObserver(
						forName: .AVPlayerItemDidPlayToEndTime,
						object: playerItem,
						queue: .main
					) { [weak avPlayer] _ in
						avPlayer?.seek(to: .zero)
						avPlayer?.play()
					}

					// Mute button
					let btn = UIButton(type: .system)
					btn.translatesAutoresizingMaskIntoConstraints = false
					let muteIcon = UIImage(systemName: "speaker.slash.fill")
					btn.setImage(muteIcon, for: .normal)
					btn.tintColor = .white
					btn.backgroundColor = UIColor.black.withAlphaComponent(0.6)
					btn.layer.cornerRadius = 16
					btn.clipsToBounds = true
					btn.addTarget(self, action: #selector(handleMutePlayer), for: .touchUpInside)
					self.muteButton = btn

					container.addSubview(btn)
					NSLayoutConstraint.activate([
						btn.widthAnchor.constraint(equalToConstant: 32),
						btn.heightAnchor.constraint(equalToConstant: 32),
						btn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
						btn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
					])

					stackView.addArrangedSubview(container)
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

	// by claude sonnet 4.6
	@objc private func handleMutePlayer() {
		guard let player = player else { return }
		player.isMuted.toggle()
		let iconName = player.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill"
		muteButton?.setImage(UIImage(systemName: iconName), for: .normal)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
