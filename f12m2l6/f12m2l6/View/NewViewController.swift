// by mioe

import UIKit

class NewViewController: UIViewController {
	var item: TableRowModel

	init(item: TableRowModel) {
		self.item = item
		super.init(nibName: nil, bundle: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemRed

		title = "NewViewController.swift"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		let preview = EntityView(item: item)
		
		view.addSubview(preview)
		
		NSLayoutConstraint.activate([
			preview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			preview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
