// by mioe

import UIKit

class ViewController: UIViewController {
	
	private let tweets = TweetModel.mock(10)
	
	lazy var layout: UICollectionViewFlowLayout = {
		$0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // динамические размеры
		$0.scrollDirection = .vertical
		$0.minimumLineSpacing = 16 // gap-y
		return $0
	}(UICollectionViewFlowLayout())
	
	lazy var collectionView: UICollectionView = {
		$0.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.cellId)
		$0.dataSource = self
		return $0
	}(UICollectionView(frame: view.frame, collectionViewLayout: layout))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		view.addSubview(collectionView)
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		tweets.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.cellId, for: indexPath) as? CollectionCell {
			let tweet = tweets[indexPath.row]
			cell.setup(tweet: tweet, collectionWidth: collectionView.bounds.width)
			return cell
		}
		return UICollectionViewCell()
	}
}
