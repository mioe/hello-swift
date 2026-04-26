// by mioe

import UIKit

class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		let mainView = UINavigationController(rootViewController: ViewController())
		mainView.tabBarItem.image = UIImage(systemName: "house")
		mainView.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
		
		let secondView = View2Controller()
		secondView.tabBarItem.image = UIImage(systemName: "person")
		secondView.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
		secondView.tabBarItem.badgeValue = "10"
		secondView.tabBarItem.badgeColor = .systemMint
		
		tabBar.tintColor = .systemPink

		viewControllers = [mainView, secondView]
	}
	
	
}
