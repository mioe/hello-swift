// by mioe

import UIKit

class ViewController: UIViewController {

	private var tableData = TableModel.mock()

	lazy var tableView: UITableView = {
		$0.dataSource = self
		$0.delegate = self
		$0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return $0
	}(UITableView(frame: view.frame))

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.black
		]
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		title = "Урок 6 - Таблицы с секциями"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		view.addSubview(tableView)
	}
}

extension ViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		tableData.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
		-> Int
	{
		tableData[section].rows.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
		-> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "cell",
			for: indexPath
		)

		let cursor = tableData[indexPath.section].rows[indexPath.row]

		var config = cell.defaultContentConfiguration()
		config.text = cursor.title
		config.secondaryText = cursor.subtitle
		config.image = UIImage(named: cursor.image)
		config.imageProperties.cornerRadius = 16
		config.imageProperties.maximumSize = CGSize(width: 48, height: 48)
		cell.contentConfiguration = config
		cell.selectionStyle = .none
		

		switch cursor.detail {
		case .common:
			cell.accessoryType = .disclosureIndicator
		case .new:
			cell.accessoryType = .detailDisclosureButton
			cell.tintColor = .systemRed
		case .sale:
			cell.accessoryType = .detailDisclosureButton
			cell.tintColor = .systemOrange
		}

		return cell
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
		-> String?
	{
		tableData[section].header
	}

	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int)
		-> String?
	{
		tableData[section].footer
	}
}

extension ViewController: UITableViewDelegate {
	func tableView(
		_ tableView: UITableView,
		commit editingStyle: UITableViewCell.EditingStyle,
		forRowAt indexPath: IndexPath
	) {
		if editingStyle == .delete {
			// порядок важен!
			tableData[indexPath.section].rows.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		let cursor = tableData[indexPath.section].rows[indexPath.row]
		switch cursor.detail {
		case .common:
			navigationController?.pushViewController(
				CommonViewController(item: cursor),
				animated: true
			)
		case .new:
			navigationController?.pushViewController(
				NewViewController(item: cursor),
				animated: true
			)
		case .sale:
			navigationController?.pushViewController(
				SaleViewController(item: cursor),
				animated: true
			)
		}
	}
}
