// by mioe

import UIKit

class ViewController: UIViewController {
	
	private let tableData = TweetModel.mock()
	
	lazy var tableView: UITableView = {
		$0.register(TweetCell.self, forCellReuseIdentifier: "cell")
		$0.dataSource = self
		$0.separatorStyle = .none // убрать 1px border-а между элементами таблицы, фиксит warning рассчета высоты кастомного элемента
		return $0
	}(UITableView(frame: view.frame, style: .plain))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		view.addSubview(tableView)
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tableData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TweetCell {
			cell.setup(tweet: tableData[indexPath.row])
			cell.selectionStyle = .none
			return cell
		}
		return UITableViewCell()
	}
}

