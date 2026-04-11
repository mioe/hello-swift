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
	func numberOfSections(in tableView: UITableView) -> Int {
		2
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0: return "Users"
		case 1: return "Groups"
		default: return nil
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		section == 0 ? users.count : groups.count
	}
	
	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		section == 0 ? "Section #\(section) - hello world" : nil
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
		
		var config = cell.defaultContentConfiguration()
		
		if indexPath.section == 0 {
			let user = users[indexPath.row]
			config.text = user.name
			config.image = UIImage(systemName: user.icon)
			config.imageProperties.tintColor = .systemOrange
		} else {
			let group = groups[indexPath.row]
			config.text = group.name
			config.secondaryText = "Group #\(indexPath.row)"
			config.image = UIImage(systemName: group.icon)
			config.imageProperties.tintColor = .systemPink
		}
		
		cell.contentConfiguration = config
		
		return cell
	}
}
