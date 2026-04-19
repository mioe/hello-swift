// by mioe

// by mioe

import UIKit

class View2Controller: UIViewController {
	
	lazy var scrollView: UIScrollView = {
		$0.backgroundColor = .black
		$0.maximumZoomScale = 2
		$0.minimumZoomScale = 1
		$0.delegate = self
		return $0
	}(UIScrollView(frame: view.frame))
	
	lazy var imageView: UIImageView = {
		$0.frame = scrollView.bounds
		$0.contentMode = .scaleAspectFit
		$0.image = .duckduckduck
		return $0
	}(UIImageView())
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		view.addSubview(scrollView)
		scrollView.addSubview(imageView)
	}
}

extension View2Controller: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		imageView
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
		let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
		imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
	}
}

