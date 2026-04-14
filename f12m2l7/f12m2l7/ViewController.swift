// by mioe

import UIKit

class ViewController: UIViewController {

	private let tableData = TweetModel.mock()

	lazy var tableView: UITableView = {
		$0.register(TweetCell.self, forCellReuseIdentifier: "cell")
		$0.dataSource = self
		$0.delegate = self
		$0.separatorStyle = .none  // убрать 1px border-а между элементами таблицы, фиксит warning рассчета высоты кастомного элемента
		return $0
	}(UITableView(frame: view.frame, style: .plain))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		view.addSubview(tableView)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		updateVisibleVideoCells()
	}

	private func updateVisibleVideoCells() {
		let visibleRect = CGRect(
			origin: tableView.contentOffset,
			size: tableView.bounds.size
		)

		for cell in tableView.visibleCells {
			guard let tweetCell = cell as? TweetCell,
				let bodyView = tweetCell.tweetBodyView,
				bodyView.hasVideo
			else { continue }

			let cellRect = tableView.convert(cell.frame, to: tableView.superview)
			let intersection = visibleRect.intersection(cellRect)
			let visibleRatio = intersection.height / cellRect.height

			if visibleRatio > 0.5 {
				bodyView.play()
			} else {
				bodyView.pause()
			}
		}
	}
}

extension ViewController: UITableViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		updateVisibleVideoCells()
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
		if let cell = tableView.dequeueReusableCell(
			withIdentifier: "cell",
			for: indexPath
		) as? TweetCell {
			cell.setup(tweet: tableData[indexPath.row])
			cell.selectionStyle = .none
			return cell
		}
		return UITableViewCell()
	}
}
