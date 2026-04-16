// by mioe

import UIKit

class ViewController: UIViewController {
	
	private let collectionData = AppStoreCollection.mock()
	
	private lazy var collectionView: UICollectionView = {
		$0.dataSource = self
		$0.register(DiscoverCell.self, forCellWithReuseIdentifier: DiscoverCell.cellId)
		$0.register(BestCell.self, forCellWithReuseIdentifier: BestCell.cellId)
		$0.register(TryCell.self, forCellWithReuseIdentifier: TryCell.cellId)
		$0.register(EssentialCell.self, forCellWithReuseIdentifier: EssentialCell.cellId)
		return $0
	}(UICollectionView(frame: view.frame, collectionViewLayout: initLayout()))

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		view.addSubview(collectionView)
	}
	
	private func initLayout() -> UICollectionViewCompositionalLayout {
		UICollectionViewCompositionalLayout { section, _ in
			switch section {
			case 0:
				return self.initDiscoverSection()
			case 1:
				return self.initBestSection()
			case 2:
				return self.initTrySection()
			default:
				return self.initEssentialSection()
			}
		}
	}
	
	private func initDiscoverSection() -> NSCollectionLayoutSection {
		// 1 init item
		// 2 init group
		// 3 init section
		
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80 + 16), heightDimension: .absolute(104)) // + 16 group
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
		group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 16)
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.contentInsets = .init(top: 0, leading: 32, bottom: 32, trailing: 32)
		
		return section
	}
	
	private func initBestSection() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(86 + 16)) // + 16 item
		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)
		group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 16)
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .groupPaging
		section.contentInsets = .init(top: 0, leading: 32, bottom: 16, trailing: 32)
		return section
	}
	
	private func initTrySection() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(216))
		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
		group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 16)
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .groupPagingCentered
		section.contentInsets = .init(top: 0, leading: 32, bottom: 32, trailing: 32)
		return section
	}
	
	private func initEssentialSection() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(86))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(86))
		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
		group.contentInsets = .init(top: 0, leading: 32, bottom: 0, trailing: 32)
		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = 16
		section.contentInsets = .init(top: 0, leading: 0, bottom: 32, trailing: 0)
		return section
	}
}

extension ViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		collectionData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		collectionData[section].items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let item = collectionData[indexPath.section].items[indexPath.item]
		
		switch indexPath.section {
		case 0:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCell.cellId, for: indexPath) as! DiscoverCell
			cell.setup(entity: item)
			return cell
		case 1:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestCell.cellId, for: indexPath) as! BestCell
			cell.setup(entity: item)
			return cell
		case 2:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TryCell.cellId, for: indexPath) as! TryCell
			cell.setup(entity: item)
			return cell
		default:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EssentialCell.cellId, for: indexPath) as! EssentialCell
			cell.setup(entity: item)
			return cell
		}
		
	}
}

