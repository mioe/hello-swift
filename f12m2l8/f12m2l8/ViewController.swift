// by mioe

import UIKit

class ViewController: UIViewController {

	lazy var layout: UICollectionViewFlowLayout = {
		return $0
	}(UICollectionViewFlowLayout())
	
	lazy var collectionView: UICollectionView = {
		return $0
	}(UICollectionView(frame: view.frame, collectionViewLayout: layout))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		view.addSubview(collectionView)
	}
}
