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
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		return cell
	}
}

class TweetCell: UITableViewCell {
	
	private lazy var wrapperView: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .red
		$0.layer.shadowColor = UIColor.black.cgColor
		$0.layer.shadowOpacity = 0.12
		$0.layer.shadowOffset = CGSize(width: 0, height: 24)
		$0.layer.shadowRadius = 42
		$0.layer.cornerRadius = 26
		return $0
	}(UIView())
	
	private lazy var header: UIView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		return $0
	}(UIView())
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setup()
	}
	
	private func setup() {
		self.contentView.addSubview(wrapperView)
		
		wrapperView.addSubview(header)
		
		NSLayoutConstraint.activate([
			// wrapperView
			wrapperView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
			wrapperView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
			wrapperView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
			wrapperView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
