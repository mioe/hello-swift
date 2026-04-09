// by mioe

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		print(view.frame)  // viewport width/height

		// &mut variables
		var h1Text = "миша гежа"
		var descriptionText = "29 лет"
		var areaText = """
			Специализируюсь на Vue3/Astro, TypeScript, Nest/Hono и PostgreSQL. Строю продукты с нуля и масштабирую существующие: от архитектуры фронтенда до CI/CD и биллинговых систем. Умею нанимать, менторить и растить разработчиков внутри команды.

			В свободное время слежу за новостями в мире IT, изучаю новые технологии и пробую применять их в личных проектах.

			🐥🐥🐤
			"""
		/// НЕ РАБОТАЕТ не перерисовывается
//		let handleEdit = UIAction { _ in
//			h1Text = "top secret"
//			descriptionText = "999 old"
//			areaText = "empty..."
//		}
//		
//		let handleRemove = UIAction { _ in
//			h1Text = "nil"
//			descriptionText = "nil"
//			areaText = "nil"
//		}

		/// consts
		let wFull = view.frame.width - 64
		let wBtn = view.frame.width - 64
		let hBtn: CGFloat = 44

		///> header
		let header = UIView(frame: CGRect(x: 32, y: 64, width: wFull, height: 120))
		header.backgroundColor = .secondarySystemBackground
		view.addSubview(header)

		let photo = UIImageView(
			frame: CGRect(
				x: 16,
				y: 16,
				width: header.frame.height - 32,
				height: header.frame.height - 32
			)
		)
		photo.image = ._1775640178368
		header.addSubview(photo)

		let photoOffsetX = 16 + 16 + photo.frame.width

		let h1 = UILabel(
			frame: CGRect(
				x: photoOffsetX,
				y: 16,
				width: header.frame.width - 32,
				height: 0
			)
		)
		h1.text = h1Text
		h1.font = .systemFont(ofSize: 20, weight: .semibold)
		h1.sizeToFit()
		header.addSubview(h1)

		let description = UILabel(
			frame: CGRect(
				x: photoOffsetX,
				y: 16 + 28 + 8,
				width: header.frame.width - 32,
				height: 0
			)
		)
		description.text = descriptionText
		description.font = .systemFont(ofSize: 14)
		description.textColor = .secondaryLabel
		description.sizeToFit()
		header.addSubview(description)
		
		let handleEdit = UIAction { _ in
			h1.text = "top secret"
			description.text = "999 old"
		}
		
		let editButton = UIButton(
			frame: CGRect(
				x: 32,
				y: header.frame.maxY + 16,
				width: wBtn,
				height: hBtn
			),
			primaryAction: handleEdit,
		)
		editButton.backgroundColor = .black
		editButton.setTitle("Редактировать профиль", for: .normal)
		editButton.setTitleColor(.white, for: .normal)
		view.addSubview(editButton)
		///< header

		///> body
		let subtitle = UILabel(
			frame: CGRect(
				x: 32,
				y: editButton.frame.maxY + 64,
				width: wFull,
				height: 0
			)
		)
		subtitle.text = "О себе"
		subtitle.font = .systemFont(ofSize: 14)
		subtitle.sizeToFit()
		view.addSubview(subtitle)

		let article = UILabel(
			frame: CGRect(
				x: 32,
				y: subtitle.frame.maxY + 16,
				width: wFull,
				height: 0
			)
		)
		article.text = areaText
		article.font = .systemFont(ofSize: 14)
		article.numberOfLines = 0
		article.lineBreakMode = .byWordWrapping
		article.backgroundColor = .secondarySystemBackground
		article.sizeToFit()
		view.addSubview(article)
		
		let handleRemove = UIAction { ev in
			article.text = "nil"
			article.sizeToFit()
			
			let target = ev.sender as! UIButton // ev.target js
			target.frame = CGRect(
				x: 32,
				y: article.frame.maxY + 16,
				width: wBtn,
				height: hBtn
			)
		}

		let removeButton = UIButton(
			frame: CGRect(
				x: 32,
				y: article.frame.maxY + 16,
				width: wBtn,
				height: hBtn
			),
			primaryAction: handleRemove,
		)
		removeButton.backgroundColor = .red
		removeButton.setTitle("Удалить данные", for: .normal)
		removeButton.setTitleColor(.white, for: .normal)
		view.addSubview(removeButton)
		///< body

		///> footer
		let footer = UIImageView(
			frame: CGRect(
				x: 32,
				y: removeButton.frame.maxY + 64,
				width: wFull,
				height: wFull / 2
			)
		)
		footer.image = .duckRight
		view.addSubview(footer)
		///< footer
	}
}
