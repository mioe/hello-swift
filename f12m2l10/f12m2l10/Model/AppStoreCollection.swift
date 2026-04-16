// by mioe

import Foundation

struct AppStoreCollection: Identifiable {
	let id: String = UUID().uuidString
	let items: [AppStoreModel]

	static func mock() -> [AppStoreCollection] {
		[
			AppStoreCollection(items: [
				AppStoreModel(
					icon: "github",
					shortName: "GitHub",
					fullName: "GitHub: Code & Projects",
					description:
						"Where the world builds software. Millions of developers and companies build, ship, and maintain their software on GitHub."
				),
				AppStoreModel(
					icon: "youtube",
					shortName: "YouTube",
					fullName: "YouTube: Watch & Stream",
					description:
						"Watch, stream, and discover what people are watching around the world. Upload your own videos and share them with friends."
				),
				AppStoreModel(
					icon: "snapchat",
					shortName: "Snapchat",
					fullName: "Snapchat: Chat & Snap",
					description:
						"Share moments with friends through snaps, stories, and discover content from publishers and creators."
				),
			]),
			AppStoreCollection(items: [
				AppStoreModel(
					icon: "claude",
					shortName: "Claude",
					fullName: "Claude: AI Assistant",
					description:
						"An AI assistant by Anthropic designed to be helpful, harmless, and honest. Chat, write, and explore ideas."
				),
				AppStoreModel(
					icon: "ollama",
					shortName: "Ollama",
					fullName: "Ollama: Local LLMs",
					description:
						"Run large language models locally on your machine. Supports Llama, Mistral, and many more open-source models."
				),
				AppStoreModel(
					icon: "firefox",
					shortName: "Firefox",
					fullName: "Firefox: Private Browser",
					description:
						"A fast, private, and safe web browser. Enhanced tracking protection blocks third-party trackers automatically."
				),
			]),
			AppStoreCollection(items: [
				AppStoreModel(
					icon: "hbo",
					shortName: "Max",
					fullName: "Max: Stream HBO & More",
					description:
						"Stream iconic series, blockbuster movies, and exclusive originals from HBO, Warner Bros., and Discovery.",
					preview: "preview-hbo"
				),
				AppStoreModel(
					icon: "linkedin",
					shortName: "LinkedIn",
					fullName: "LinkedIn: Network & Jobs",
					description:
						"Build your professional network and stay connected with colleagues. Discover job opportunities and industry news.",
					preview: "preview-linkedin"
				),
				AppStoreModel(
					icon: "dropbox",
					shortName: "Dropbox",
					fullName: "Dropbox: Cloud Storage",
					description:
						"Keep all your files safe and accessible from any device. Share folders and collaborate with your team seamlessly.",
					preview: "preview-dropbox"
				),
			]),
			AppStoreCollection(items: [
				AppStoreModel(
					icon: "gemini",
					shortName: "Gemini",
					fullName: "Gemini: AI by Google",
					description:
						"Google's AI assistant powered by Gemini models. Get help with writing, planning, learning, and more.",
					preview: "preview-gemini"
				),
				AppStoreModel(
					icon: "twitch",
					shortName: "Twitch",
					fullName: "Twitch: Live Streaming",
					description:
						"Watch live streams of your favorite games, esports events, and creative content from millions of streamers.",
					preview: "preview-twitch"
				),
				AppStoreModel(
					icon: "meta-ai",
					shortName: "Meta AI",
					fullName: "Meta AI: Chat Assistant",
					description:
						"An AI assistant from Meta. Have conversations, generate images, and get help with everyday tasks.",
					preview: "preview-meta-ai"
				),
				AppStoreModel(
					icon: "peacock",
					shortName: "Peacock",
					fullName: "Peacock: Stream TV & Movies",
					description:
						"Stream hit shows, live sports, and exclusive originals from NBC Universal all in one place.",
					preview: "preview-peacock"
				),
			]),
		]
	}
}
