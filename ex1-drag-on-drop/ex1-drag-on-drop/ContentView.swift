// by mioe
// via 1 prompt by claude opus 4.7 (adaptive)
// Fri, 08 May 2026 09:07:11 GMT

import SwiftUI
import UIKit


struct ContentView: View {
	var body: some View {
		CanvasView()
			.ignoresSafeArea()
	}
}

/// SwiftUI обёртка над UIKit-канвасом.
/// Снаружи — декларативно, внутри — императивный контроль над жестами.
struct CanvasView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> CanvasViewController {
		CanvasViewController()
	}

	func updateUIViewController(_ vc: CanvasViewController, context: Context) {}
}

// MARK: - Canvas View Controller

final class CanvasViewController: UIViewController {

	// Контейнер, в котором живут виджеты. Выделен отдельно ради экспорта:
	// рендерим именно его, без тулбаров и оверлеев.
	private let canvasContainer = UIView()

	// Фон — для демо просто градиент. В реальном коде сюда ляжет UIImageView.
	private let backgroundView = GradientView()

	// Оверлей выделения (один на весь канвас, переиспользуется).
	private let selectionOverlay = SelectionOverlayView()

	// Snap-гайды.
	private let verticalGuide = UIView()
	private let horizontalGuide = UIView()

	// Trash zone сверху.
	private let trashZone = TrashZoneView()

	// Тулбар снизу: добавить текст / картинку / Done.
	private let toolbar = UIStackView()

	// Текущий выделенный виджет.
	private weak var selectedWidget: WidgetView? {
		didSet {
			oldValue.map { _ in updateSelectionOverlay() }
			updateSelectionOverlay()
		}
	}

	// Чтобы не дёргать haptic на каждом кадре снапа.
	private var didHapticOnVerticalSnap = false
	private var didHapticOnHorizontalSnap = false

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		setupBackground()
		setupCanvas()
		setupSelectionOverlay()
		setupGuides()
		setupTrashZone()
		setupToolbar()
		setupBackgroundTap()

		// Стартовый контент для демо.
		addTextWidget(text: "Tap me ✨", at: CGPoint(x: 200, y: 300))
		addImageWidget(
			systemName: "heart.fill",
			tint: .systemPink,
			at: CGPoint(x: 150, y: 450)
		)
	}

	// MARK: Setup

	private func setupBackground() {
		backgroundView.frame = view.bounds
		backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(backgroundView)
	}

	private func setupCanvas() {
		canvasContainer.frame = view.bounds
		canvasContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		canvasContainer.backgroundColor = .clear
		view.addSubview(canvasContainer)
	}

	private func setupSelectionOverlay() {
		selectionOverlay.isHidden = true
		selectionOverlay.onDelete = { [weak self] in
			guard let self, let w = self.selectedWidget else { return }
			self.deleteWidget(w, animated: true)
		}
		view.addSubview(selectionOverlay)
	}

	private func setupGuides() {
		for guide in [verticalGuide, horizontalGuide] {
			guide.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.9)
			guide.isHidden = true
			guide.isUserInteractionEnabled = false
			view.addSubview(guide)
		}
	}

	private func setupTrashZone() {
		trashZone.translatesAutoresizingMaskIntoConstraints = false
		trashZone.alpha = 0
		view.addSubview(trashZone)
		NSLayoutConstraint.activate([
			trashZone.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			trashZone.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 16
			),
			trashZone.widthAnchor.constraint(equalToConstant: 72),
			trashZone.heightAnchor.constraint(equalToConstant: 72),
		])
	}

	private func setupToolbar() {
		toolbar.axis = .horizontal
		toolbar.distribution = .equalSpacing
		toolbar.alignment = .center
		toolbar.translatesAutoresizingMaskIntoConstraints = false

		let addText = makeToolbarButton(systemImage: "textformat", title: "Text") {
			[weak self] in
			self?.addTextWidget(
				text: "New text",
				at: CGPoint(
					x: self?.view.bounds.midX ?? 200,
					y: self?.view.bounds.midY ?? 300
				)
			)
		}

		let addImage = makeToolbarButton(systemImage: "photo", title: "Image") {
			[weak self] in
			// Для демо — случайный SF Symbol.
			let symbols = [
				"star.fill", "bolt.fill", "flame.fill",
				"leaf.fill", "moon.stars.fill", "sparkles",
			]
			let tints: [UIColor] = [
				.systemYellow, .systemBlue, .systemOrange,
				.systemGreen, .systemPurple, .systemPink,
			]
			let i = Int.random(in: 0..<symbols.count)
			self?.addImageWidget(
				systemName: symbols[i],
				tint: tints[i],
				at: CGPoint(
					x: self?.view.bounds.midX ?? 200,
					y: self?.view.bounds.midY ?? 400
				)
			)
		}

		let done = makeToolbarButton(
			systemImage: "checkmark.circle.fill",
			title: "Done"
		) { [weak self] in
			self?.exportComposite()
		}

		[addText, addImage, done].forEach { toolbar.addArrangedSubview($0) }
		view.addSubview(toolbar)

		NSLayoutConstraint.activate([
			toolbar.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: 32
			),
			toolbar.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -32
			),
			toolbar.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -16
			),
			toolbar.heightAnchor.constraint(equalToConstant: 64),
		])
	}

	private func makeToolbarButton(
		systemImage: String,
		title: String,
		action: @escaping () -> Void
	) -> UIButton {
		var config = UIButton.Configuration.filled()
		config.image = UIImage(systemName: systemImage)
		config.title = title
		config.imagePadding = 6
		config.baseBackgroundColor = UIColor.white.withAlphaComponent(0.18)
		config.baseForegroundColor = .white
		config.cornerStyle = .capsule
		let btn = UIButton(
			configuration: config,
			primaryAction: UIAction { _ in action() }
		)
		return btn
	}

	private func setupBackgroundTap() {
		// Тап по фону — снять выделение.
		let tap = UITapGestureRecognizer(
			target: self,
			action: #selector(handleBackgroundTap)
		)
		canvasContainer.addGestureRecognizer(tap)
	}

	@objc private func handleBackgroundTap() {
		selectedWidget = nil
	}

	// MARK: Widget creation

	private func addTextWidget(text: String, at point: CGPoint) {
		let widget = TextWidgetView(text: text)
		widget.delegate = self
		widget.center = point
		canvasContainer.addSubview(widget)
		select(widget)
	}

	private func addImageWidget(
		systemName: String,
		tint: UIColor,
		at point: CGPoint
	) {
		let widget = ImageWidgetView(systemName: systemName, tint: tint)
		widget.delegate = self
		widget.center = point
		canvasContainer.addSubview(widget)
		select(widget)
	}

	private func select(_ widget: WidgetView) {
		canvasContainer.bringSubviewToFront(widget)
		selectedWidget = widget
	}

	private func deleteWidget(_ widget: WidgetView, animated: Bool) {
		if selectedWidget === widget { selectedWidget = nil }
		guard animated else {
			widget.removeFromSuperview()
			return
		}
		UIView.animate(
			withDuration: 0.22,
			animations: {
				widget.transform = widget.transform.scaledBy(x: 0.01, y: 0.01)
				widget.alpha = 0
			},
			completion: { _ in widget.removeFromSuperview() }
		)
	}

	// MARK: Selection overlay

	private func updateSelectionOverlay() {
		guard let widget = selectedWidget else {
			selectionOverlay.isHidden = true
			return
		}
		selectionOverlay.isHidden = false
		// Берём frame в координатах view — он уже учитывает transform виджета.
		let frameInView = canvasContainer.convert(widget.frame, to: view)
		selectionOverlay.frame = frameInView.insetBy(dx: -10, dy: -10)
		// Поворот рамки повторяет поворот виджета.
		let angle = atan2(widget.transform.b, widget.transform.a)
		// frame уже включает поворот, поэтому рамку выравниваем по нему вручную:
		// используем bounds + transform виджета для точного оверлея.
		let bounds = widget.bounds.insetBy(dx: -10, dy: -10)
		selectionOverlay.bounds = bounds
		selectionOverlay.center = canvasContainer.convert(widget.center, to: view)
		selectionOverlay.transform = CGAffineTransform(rotationAngle: angle)
			.scaledBy(
				x: scaleX(of: widget.transform),
				y: scaleY(of: widget.transform)
			)
	}

	private func scaleX(of t: CGAffineTransform) -> CGFloat {
		sqrt(t.a * t.a + t.c * t.c)
	}
	private func scaleY(of t: CGAffineTransform) -> CGFloat {
		sqrt(t.b * t.b + t.d * t.d)
	}

	// MARK: Snap & trash during drag

	fileprivate func handleDragChange(
		_ widget: WidgetView,
		state: UIGestureRecognizer.State
	) {
		switch state {
		case .began:
			UIView.animate(withDuration: 0.2) { self.trashZone.alpha = 1 }
		case .changed:
			applySnap(to: widget)
			updateTrashState(for: widget)
			updateSelectionOverlay()
		case .ended, .cancelled, .failed:
			verticalGuide.isHidden = true
			horizontalGuide.isHidden = true
			didHapticOnVerticalSnap = false
			didHapticOnHorizontalSnap = false

			if isOverTrash(widget) {
				deleteWidget(widget, animated: true)
			}
			UIView.animate(withDuration: 0.2) { self.trashZone.alpha = 0 }
			trashZone.setActive(false)
			updateSelectionOverlay()
		default:
			updateSelectionOverlay()
		}
	}

	fileprivate func handleTransformChange(_ widget: WidgetView) {
		updateSelectionOverlay()
	}

	private func applySnap(to widget: WidgetView) {
		let threshold: CGFloat = 6
		let canvasCenter = CGPoint(
			x: canvasContainer.bounds.midX,
			y: canvasContainer.bounds.midY
		)

		// По X
		if abs(widget.center.x - canvasCenter.x) < threshold {
			widget.center.x = canvasCenter.x
			verticalGuide.frame = CGRect(
				x: canvasCenter.x - 0.5,
				y: 0,
				width: 1,
				height: view.bounds.height
			)
			verticalGuide.isHidden = false
			if !didHapticOnVerticalSnap {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
				didHapticOnVerticalSnap = true
			}
		} else {
			verticalGuide.isHidden = true
			didHapticOnVerticalSnap = false
		}

		// По Y
		if abs(widget.center.y - canvasCenter.y) < threshold {
			widget.center.y = canvasCenter.y
			horizontalGuide.frame = CGRect(
				x: 0,
				y: canvasCenter.y - 0.5,
				width: view.bounds.width,
				height: 1
			)
			horizontalGuide.isHidden = false
			if !didHapticOnHorizontalSnap {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
				didHapticOnHorizontalSnap = true
			}
		} else {
			horizontalGuide.isHidden = true
			didHapticOnHorizontalSnap = false
		}
	}

	private func isOverTrash(_ widget: WidgetView) -> Bool {
		let widgetCenterInView = canvasContainer.convert(widget.center, to: view)
		return trashZone.frame.insetBy(dx: -8, dy: -8).contains(widgetCenterInView)
	}

	private func updateTrashState(for widget: WidgetView) {
		let over = isOverTrash(widget)
		trashZone.setActive(over)
	}

	// MARK: Export

	private func exportComposite() {
		// Скрываем то, что не должно попасть в финал.
		selectionOverlay.isHidden = true
		verticalGuide.isHidden = true
		horizontalGuide.isHidden = true

		let renderer = UIGraphicsImageRenderer(bounds: canvasContainer.bounds)
		let image = renderer.image { _ in
			// Фон + канвас.
			backgroundView.drawHierarchy(
				in: canvasContainer.bounds,
				afterScreenUpdates: true
			)
			canvasContainer.drawHierarchy(
				in: canvasContainer.bounds,
				afterScreenUpdates: true
			)
		}

		// Восстанавливаем выделение.
		updateSelectionOverlay()

		// Показываем превью.
		let preview = ExportPreviewController(image: image)
		preview.modalPresentationStyle = .pageSheet
		present(preview, animated: true)
	}
}

// MARK: - WidgetDelegate

protocol WidgetDelegate: AnyObject {
	func widgetDidTap(_ widget: WidgetView)
	func widgetDidDoubleTap(_ widget: WidgetView)
	func widgetDidPan(_ widget: WidgetView, state: UIGestureRecognizer.State)
	func widgetDidTransform(_ widget: WidgetView)
}

extension CanvasViewController: WidgetDelegate {
	func widgetDidTap(_ widget: WidgetView) { select(widget) }

	func widgetDidDoubleTap(_ widget: WidgetView) {
		select(widget)
		if let text = widget as? TextWidgetView {
			presentTextEditor(for: text)
		}
	}

	func widgetDidPan(_ widget: WidgetView, state: UIGestureRecognizer.State) {
		if state == .began { select(widget) }
		handleDragChange(widget, state: state)
	}

	func widgetDidTransform(_ widget: WidgetView) {
		handleTransformChange(widget)
	}

	private func presentTextEditor(for widget: TextWidgetView) {
		let alert = UIAlertController(
			title: "Edit text",
			message: nil,
			preferredStyle: .alert
		)
		alert.addTextField { tf in tf.text = widget.text }
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		alert.addAction(
			UIAlertAction(title: "Save", style: .default) {
				[weak self, weak alert] _ in
				guard let new = alert?.textFields?.first?.text, !new.isEmpty else {
					return
				}
				// Сохраняем центр, чтобы виджет не "прыгнул" при изменении размера.
				let centerBefore = widget.center
				widget.text = new
				widget.center = centerBefore
				self?.updateSelectionOverlay()
			}
		)
		present(alert, animated: true)
	}
}

// MARK: - WidgetView (base)

class WidgetView: UIView, UIGestureRecognizerDelegate {

	weak var delegate: WidgetDelegate?

	private let minScale: CGFloat = 0.3
	private let maxScale: CGFloat = 5.0

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
		setupGestures()
	}

	required init?(coder: NSCoder) { fatalError() }

	private func setupGestures() {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
		pan.minimumNumberOfTouches = 1
		pan.maximumNumberOfTouches = 1
		let pinch = UIPinchGestureRecognizer(
			target: self,
			action: #selector(handlePinch)
		)
		let rotate = UIRotationGestureRecognizer(
			target: self,
			action: #selector(handleRotate)
		)
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		let doubleTap = UITapGestureRecognizer(
			target: self,
			action: #selector(handleDoubleTap)
		)
		doubleTap.numberOfTapsRequired = 2
		tap.require(toFail: doubleTap)

		for g in [pan, pinch, rotate] as [UIGestureRecognizer] {
			g.delegate = self
			addGestureRecognizer(g)
		}
		addGestureRecognizer(tap)
		addGestureRecognizer(doubleTap)
	}

	// MARK: Handlers

	@objc private func handlePan(_ g: UIPanGestureRecognizer) {
		guard let superview else { return }
		let t = g.translation(in: superview)
		center = CGPoint(x: center.x + t.x, y: center.y + t.y)
		g.setTranslation(.zero, in: superview)

		if g.state == .began { superview.bringSubviewToFront(self) }
		delegate?.widgetDidPan(self, state: g.state)
	}

	@objc private func handlePinch(_ g: UIPinchGestureRecognizer) {
		guard g.state == .began || g.state == .changed else {
			delegate?.widgetDidTransform(self)
			return
		}
		let currentScale = sqrt(
			transform.a * transform.a + transform.c * transform.c
		)
		let proposed = currentScale * g.scale
		let clamped = min(max(proposed, minScale), maxScale)
		let factor = clamped / currentScale
		transform = transform.scaledBy(x: factor, y: factor)
		g.scale = 1
		delegate?.widgetDidTransform(self)
	}

	@objc private func handleRotate(_ g: UIRotationGestureRecognizer) {
		transform = transform.rotated(by: g.rotation)
		g.rotation = 0
		delegate?.widgetDidTransform(self)
	}

	@objc private func handleTap() { delegate?.widgetDidTap(self) }
	@objc private func handleDoubleTap() { delegate?.widgetDidDoubleTap(self) }

	// Все жесты работают одновременно (pan + pinch + rotate).
	func gestureRecognizer(
		_ a: UIGestureRecognizer,
		shouldRecognizeSimultaneouslyWith b: UIGestureRecognizer
	) -> Bool {
		true
	}
}

// MARK: - TextWidgetView

final class TextWidgetView: WidgetView {

	private let label = UILabel()

	var text: String {
		get { label.text ?? "" }
		set {
			label.text = newValue
			sizeToFitContent()
		}
	}

	init(text: String) {
		super.init(frame: .zero)
		label.font = .systemFont(ofSize: 36, weight: .bold)
		label.textColor = .white
		label.textAlignment = .center
		label.numberOfLines = 0
		// Тень для читаемости на любом фоне.
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowOpacity = 0.4
		label.layer.shadowRadius = 4
		label.layer.shadowOffset = CGSize(width: 0, height: 2)
		addSubview(label)
		self.text = text
	}

	required init?(coder: NSCoder) { fatalError() }

	private func sizeToFitContent() {
		label.sizeToFit()
		let pad: CGFloat = 12
		bounds = CGRect(
			x: 0,
			y: 0,
			width: label.bounds.width + pad * 2,
			height: label.bounds.height + pad
		)
		label.center = CGPoint(x: bounds.midX, y: bounds.midY)
	}
}

// MARK: - ImageWidgetView

final class ImageWidgetView: WidgetView {

	private let imageView = UIImageView()

	init(systemName: String, tint: UIColor) {
		super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		let config = UIImage.SymbolConfiguration(pointSize: 80, weight: .bold)
		imageView.image = UIImage(systemName: systemName, withConfiguration: config)
		imageView.tintColor = tint
		imageView.contentMode = .scaleAspectFit
		imageView.frame = bounds
		imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		// Лёгкое свечение, чтобы виджет читался на любом фоне.
		imageView.layer.shadowColor = UIColor.black.cgColor
		imageView.layer.shadowOpacity = 0.35
		imageView.layer.shadowRadius = 6
		imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
		addSubview(imageView)
	}

	required init?(coder: NSCoder) { fatalError() }
}

// MARK: - SelectionOverlayView

final class SelectionOverlayView: UIView {

	var onDelete: (() -> Void)?

	private let border = CAShapeLayer()
	private let deleteButton = UIButton(type: .system)

	override init(frame: CGRect) {
		super.init(frame: frame)
		isUserInteractionEnabled = true
		backgroundColor = .clear

		border.fillColor = UIColor.clear.cgColor
		border.strokeColor = UIColor.white.cgColor
		border.lineWidth = 1.5
		border.lineDashPattern = [4, 3]
		layer.addSublayer(border)

		deleteButton.setImage(
			UIImage(systemName: "xmark.circle.fill"),
			for: .normal
		)
		deleteButton.tintColor = .white
		deleteButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		deleteButton.layer.cornerRadius = 14
		deleteButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
		deleteButton.addAction(
			UIAction { [weak self] _ in self?.onDelete?() },
			for: .touchUpInside
		)
		addSubview(deleteButton)
	}

	required init?(coder: NSCoder) { fatalError() }

	override func layoutSubviews() {
		super.layoutSubviews()
		border.path = UIBezierPath(rect: bounds).cgPath
		border.frame = bounds
		// Кнопка удаления в левом верхнем углу.
		deleteButton.center = CGPoint(x: 0, y: 0)
	}

	// Хит-тест должен пропускать всё кроме самой кнопки —
	// иначе оверлей блокирует жесты на виджете.
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let inDelete = deleteButton.frame.insetBy(dx: -8, dy: -8).contains(point)
		return inDelete ? deleteButton : nil
	}
}

// MARK: - TrashZoneView

final class TrashZoneView: UIView {

	private let icon = UIImageView()
	private let bg = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(bg)
		addSubview(icon)

		bg.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		bg.layer.cornerRadius = 36
		bg.translatesAutoresizingMaskIntoConstraints = false

		icon.image = UIImage(systemName: "trash.fill")
		icon.tintColor = .white
		icon.contentMode = .scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			bg.topAnchor.constraint(equalTo: topAnchor),
			bg.leadingAnchor.constraint(equalTo: leadingAnchor),
			bg.trailingAnchor.constraint(equalTo: trailingAnchor),
			bg.bottomAnchor.constraint(equalTo: bottomAnchor),

			icon.centerXAnchor.constraint(equalTo: centerXAnchor),
			icon.centerYAnchor.constraint(equalTo: centerYAnchor),
			icon.widthAnchor.constraint(equalToConstant: 28),
			icon.heightAnchor.constraint(equalToConstant: 28),
		])
	}

	required init?(coder: NSCoder) { fatalError() }

	func setActive(_ active: Bool) {
		UIView.animate(withDuration: 0.18) {
			self.bg.backgroundColor =
				active
				? UIColor.systemRed.withAlphaComponent(0.85)
				: UIColor.black.withAlphaComponent(0.5)
			self.transform =
				active
				? CGAffineTransform(scaleX: 1.15, y: 1.15)
				: .identity
		}
	}
}

// MARK: - GradientView (background placeholder)

final class GradientView: UIView {
	override class var layerClass: AnyClass { CAGradientLayer.self }
	override init(frame: CGRect) {
		super.init(frame: frame)
		let gradient = layer as! CAGradientLayer
		gradient.colors = [
			UIColor(red: 0.15, green: 0.18, blue: 0.32, alpha: 1).cgColor,
			UIColor(red: 0.45, green: 0.20, blue: 0.45, alpha: 1).cgColor,
			UIColor(red: 0.90, green: 0.35, blue: 0.40, alpha: 1).cgColor,
		]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 1, y: 1)
	}
	required init?(coder: NSCoder) { fatalError() }
}

// MARK: - Export Preview

final class ExportPreviewController: UIViewController {
	private let image: UIImage
	init(image: UIImage) {
		self.image = image
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) { fatalError() }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = "Exported"

		let iv = UIImageView(image: image)
		iv.contentMode = .scaleAspectFit
		iv.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(iv)

		let close = UIButton(
			configuration: .filled(),
			primaryAction: UIAction(title: "Close") { [weak self] _ in
				self?.dismiss(animated: true)
			}
		)
		close.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(close)

		NSLayoutConstraint.activate([
			iv.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: 16
			),
			iv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			iv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			iv.bottomAnchor.constraint(equalTo: close.topAnchor, constant: -16),

			close.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			close.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -16
			),
		])
	}
}
