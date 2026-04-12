// by mioe

import UIKit

class ViewController: UIViewController {
	
	private let tableData = TableModel.mock()
	
	lazy var tableView: UITableView = {
		$0.dataSource = self
		$0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return $0
	}(UITableView(frame: view.frame))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		title = "Урок 6 - Таблицы с секциями"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never
		
		view.addSubview(tableView)
	}
}

func getImageViaSectionAndDetail(_ section: Int, _ detail: Int) -> UIImage? {
	UIImage()
}

extension ViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		tableData.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tableData[section].rows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		let cursor = tableData[indexPath.section].rows[indexPath.row]
		
		var config = cell.defaultContentConfiguration()
		config.text = cursor.title
		config.secondaryText = cursor.subtitle
		cell.contentConfiguration = config
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		tableData[section].header
	}
	
	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		tableData[section].footer
	}
}
