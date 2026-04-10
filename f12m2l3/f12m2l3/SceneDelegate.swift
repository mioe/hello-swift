// by mioe

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		// 1
		guard let scene = (scene as? UIWindowScene) else { return }
		
		// 2
		self.window = UIWindow(windowScene: scene)
		
		// 3
		self.window?.rootViewController = ViewController()
		
		// 4
		self.window?.makeKeyAndVisible()
	}
}

