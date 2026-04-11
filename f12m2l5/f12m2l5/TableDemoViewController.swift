// by mioe

import UIKit

class TableDemoViewController: UIViewController {
	private let users: [UserModel] = UserModel.mock(count: 5)
	private let groups: [GroupModel] = GroupModel.mock(count: 5)
	
	private lazy var tableView: UITableView = {
		$0.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
		$0.dataSource = self
		return $0
	}(UITableView(frame: view.frame, style: .insetGrouped))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		view.addSubview(tableView)
	}
}

extension TableDemoViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
		
		var config = cell.defaultContentConfiguration()
		config.text = "User #\(indexPath.row)"
		config.secondaryText = users[indexPath.row].name
		config.image = UIImage(systemName: users[indexPath.row].icon)
		config.imageProperties.tintColor = .systemBlue
		
		cell.contentConfiguration = config
		
		print("recreated")
		return cell
	}
}
