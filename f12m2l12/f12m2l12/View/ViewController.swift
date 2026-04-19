// by mioe

import UIKit

class ViewController: UIViewController {
	
	private lazy var scrollView: UIScrollView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.showsVerticalScrollIndicator = false
		$0.showsHorizontalScrollIndicator = false
		return $0
	}(UIScrollView())
	
	private lazy var stackView: UIStackView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.axis = .vertical
		$0.spacing = 16
		$0.alignment = .fill
		$0.distribution = .fill
		return $0
	}(UIStackView())
	
	private lazy var imageView: UIImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.contentMode = .scaleAspectFill
		$0.layer.cornerRadius = 16
		$0.clipsToBounds = true
		$0.image = .duckduckduck
		return $0
	}(UIImageView())
	
	private lazy var loremTextView: UILabel = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.text = """
			Кря. Кря кря. Кря кря кря. Уточка. Кря кря кря кря кря. Уточка кря. Кря. Утка. Кря кря. Уточка кря кря кря. Кря. Кря кря кря кря. Утка кря кря. Кря кря уточка. Кря.
			Уточка кря кря кря кря. Кря уточка. Кря кря. Утка утка утка. Кря кря кря. Уточка. Кря. Кря кря утка кря. Уточка кря кря. Кря кря кря. Утка. Кря кря кря кря кря кря. Уточка кря. Кря. Утка кря кря кря. Кря кря. Уточка уточка. Кря кря кря кря. Кря утка. Кря.
			
			Утка кря кря. Уточка кря кря кря кря. Кря. Утка утка кря. Кря кря кря. Уточка. Кря кря кря кря кря. Утка. Кря уточка кря. Кря кря. Утка кря кря кря. Кря. Уточка кря кря. Кря кря кря кря. Утка кря. Кря. Кря кря утка. Уточка кря кря кря. Кря кря кря.
			
			Утка. Кря кря кря кря кря. Уточка утка. Кря. Кря кря кря. Утка кря кря. Кря. Уточка кря кря кря кря. Кря кря. Утка утка кря. Кря кря кря кря. Уточка. Кря утка кря. Кря кря кря. Утка. Кря. Уточка кря кря. Кря кря кря кря кря. Утка кря. Кря кря уточка. Кря.
			
			Кря кря кря. Утка уточка кря кря. Кря. Кря кря кря кря. Утка кря кря кря. Уточка. Кря кря. Утка кря кря кря кря. Кря кря кря. Уточка утка. Кря. Кря кря кря кря кря кря. Утка. Кря уточка кря кря. Кря кря кря. Утка кря. Кря. Уточка кря кря кря кря. Кря кря. Утка.
			Кря кря кря кря. Уточка кря кря. Утка кря. Кря. Кря кря кря. Уточка. Кря кря кря кря кря. Утка утка кря. Кря кря. Уточка кря кря кря. Кря. Утка кря кря кря кря. Кря кря кря. Уточка. Кря утка кря. Кря кря кря кря. Утка кря кря. Кря. Уточка кря кря кря. Кря кря кря кря кря.
			
			Утка. Кря. Уточка кря кря кря кря кря. Кря кря. Утка кря кря. Кря кря кря. Уточка утка утка. Кря. Кря кря кря кря. Утка кря. Кря кря уточка. Кря кря кря. Утка. Кря кря кря кря кря. Уточка кря кря. Кря. Утка кря кря кря. Кря кря. Уточка. Кря кря кря кря. Утка кря кря кря. Кря. Кря утка уточка. Кря кря кря. Утка кря. Кря кря кря кря. Уточка. Кря.
			"""
		$0.numberOfLines = 0
		return $0
	}(UILabel())
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		title = "ViewController"
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "gear"),
			style: .plain,
			target: self,
			action: #selector(handleSettings)
		)
		
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(loremTextView)
		
		view.addSubview(scrollView)
		scrollView.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
			stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			stackView.widthAnchor.constraint(
				equalTo: scrollView.widthAnchor,
				constant: -64
			),

			imageView.heightAnchor.constraint(equalToConstant: 200),
		])
	}
	
	@objc
	func handleSettings() {
		let settingsView = SettingsViewController()
		navigationController?.pushViewController(settingsView, animated: true)
	}
}

