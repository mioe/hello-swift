// by mioe

import UIKit

class ViewController: UIViewController {
	
	private let tweets = TweetModel.mock()

	lazy var layout: UICollectionViewFlowLayout = {
		let spacing: CGFloat = 8 // minimal by tailwind
		let gapX = spacing * 2
		let gapY = spacing * 2
		
		$0.itemSize = CGSize(width: (view.frame.width - gapX * 3) / 2, height: 200)
		$0.scrollDirection = .vertical
		$0.minimumLineSpacing = gapY // gap-y
		$0.minimumInteritemSpacing = gapX // gap-x
		$0.sectionInset = UIEdgeInsets(top: gapY, left: gapX, bottom: gapY, right: gapX)
		return $0
	}(UICollectionViewFlowLayout())
	
	lazy var collectionView: UICollectionView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.cellId)
		$0.dataSource = self
		return $0
	}(UICollectionView(frame: view.frame, collectionViewLayout: layout))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
		])
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		tweets.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.cellId, for: indexPath) as? CollectionCell {
			cell.setup(tweet: tweets[indexPath.row])
			return cell
		}
		return UICollectionViewCell()
	}
}
