// by mioe

import UIKit

class ViewController: UIViewController {
	
	private let tableData = TweetModel.mock()
	
	lazy var tableView: UITableView = {
		$0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		$0.dataSource = self
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = tableData[indexPath.row].text
		return cell
	}
}
