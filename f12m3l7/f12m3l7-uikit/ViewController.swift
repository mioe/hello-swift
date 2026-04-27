// by mioe

import SwiftUI
import UIKit

class ViewController: UIViewController {

	private let tableData = TweetModel.mock()

	lazy var tableView: UITableView = {
		$0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		$0.dataSource = self
		$0.separatorStyle = .none
		return $0
	}(UITableView(frame: view.frame, style: .plain))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		view.addSubview(tableView)
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
		-> Int
	{
		tableData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
		-> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "cell",
			for: indexPath
		)
		cell.contentConfiguration = UIHostingConfiguration {
			TweetView(tweet: tableData[indexPath.row])
		}
		return cell
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
		-> String?
	{
		"Tweets"
	}
}

struct TweetView: View {
	let tweet: TweetModel

	var body: some View {
		VStack {
			HStack(alignment: .top, spacing: 8) {
				if !tweet.media.isEmpty {
					Image(tweet.media.first ?? "img1")
						.resizable()
						.scaledToFill()
						.frame(width: 48, height: 48)
						.clipShape(RoundedRectangle(cornerRadius: 8))
				}

				VStack(alignment: .leading, spacing: 4) {
					Text(tweet.text)
						.font(.system(size: 14))
					Text("@" + tweet.user.nickname)
						.font(.system(size: 12))
						.foregroundStyle(.secondary)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
			Divider()
		}
	}
}
