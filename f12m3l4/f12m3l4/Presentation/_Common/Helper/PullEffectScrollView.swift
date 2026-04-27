//
//  PullEffectScrollView.swift
//  ChromePullEffect
//  > https://youtu.be/FuvooYFyiJU?si=7SgmMZ5ohcqbQBIL
//
//  Created by Balaji Venkatesh on 19/07/25.
//  + opus 4.7 patched
//

import SwiftUI

struct PullEffectScrollView<Content: View>: View {
	var dragDistance: CGFloat = 100
	var actionTopPadding: CGFloat = 0
	var leadingAction: PullEffectAction
	var centerAction: PullEffectAction
	var trailingAction: PullEffectAction
	@ViewBuilder var content: Content
	/// View Properties
	@State private var effectProgress: CGFloat = 0
	@State private var scrollOffset: CGFloat = 0
	/// ★ захват offset'а теперь в onChanged (см. ниже)
	@State private var initialScrollOffset: CGFloat?
	@State private var activePosition: ActionPosition?
	@State private var scaleEffect: Bool = false
	/// Haptics
	@State private var hapticsTrigger: Bool = false
	@Namespace private var animation

	var body: some View {
		ScrollView(.vertical) {
			content
		}
		.onScrollGeometryChange(
			for: CGFloat.self,
			of: {
				$0.contentOffset.y + $0.contentInsets.top
			},
			action: { _, newValue in
				scrollOffset = newValue
			}
		)
		.simultaneousGesture(
			DragGesture(minimumDistance: 0)
				.onChanged { value in
					// ★ FIX: захватываем initial offset на первом тике жеста.
					// Раньше это делалось через @GestureState + .onChange,
					// но там гонка: scrollOffset успевает уйти в overscroll
					// до того как @GestureState обновится → guard ниже фейлится
					// и жест «проглатывается» при быстрых свайпах.
					if initialScrollOffset == nil {
						initialScrollOffset = scrollOffset.rounded()
					}

					/// Only Allowing Custom Pull Action when it's not scrolled!
					guard initialScrollOffset == 0 else { return }

					let translationY = value.translation.height
					let progress = min(max(translationY / dragDistance, 0), 1)
					effectProgress = progress

					guard translationY >= dragDistance else {
						if activePosition != nil {
							activePosition = nil
						}
						return
					}

					let translationX = value.translation.width
					let indexProgress = translationX / dragDistance
					let index: Int =
						-indexProgress > 0.5 ? -1 : (indexProgress > 0.5 ? 1 : 0)

					// ActionPosition имеет Int rawValue → можно инициализировать напрямую
					let landingAction = ActionPosition(rawValue: index)

					if activePosition != landingAction {
						hapticsTrigger.toggle()
					}

					activePosition = landingAction
				}
				.onEnded { _ in
					// ★ FIX: гарантированный сброс initialScrollOffset через defer,
					// чтобы следующий жест всегда стартовал с чистого состояния
					// (даже если ниже сработает early return).
					defer { initialScrollOffset = nil }

					guard effectProgress != 0 else { return }

					if let position = activePosition {
						hapticsTrigger.toggle()

						withAnimation(
							.easeInOut(duration: 0.25),
							completionCriteria: .logicallyComplete
						) {
							scaleEffect = true
						} completion: {
							scaleEffect = false
							effectProgress = 0
							self.activePosition = nil
						}

						/// Calling respective Actions
						switch position {
						case .leading: leadingAction.action()
						case .center: centerAction.action()
						case .trailing: trailingAction.action()
						}
					} else {
						withAnimation(.easeInOut(duration: 0.25)) {
							effectProgress = 0
						}
					}
				},
			isEnabled: !scaleEffect
		)
		.background(alignment: .top) {
			ActionsView()
				.padding(.top, actionTopPadding)
				.ignoresSafeArea()
		}
		.sensoryFeedback(.impact, trigger: hapticsTrigger)
	}

	/// Actions View
	@ViewBuilder
	private func ActionsView() -> some View {
		HStack(spacing: 0) {
			/// Delay progress for leading and trailer actions
			let delayedProgress = (effectProgress - 0.7) / 0.3

			ActionButton(.leading)
				.offset(x: 30 * (1 - delayedProgress))
				.opacity(delayedProgress)

			ActionButton(.center)
				/// Adding Blur Effect
				.blur(radius: 10 * (1 - effectProgress))
				.opacity(effectProgress)

			ActionButton(.trailing)
				.offset(x: -30 * (1 - delayedProgress))
				.opacity(delayedProgress)
		}
		.padding(.horizontal, 20)
		// MARK: Optional!
		.opacity(scaleEffect ? 0 : 1)
	}

	/// Action Button
	@ViewBuilder
	private func ActionButton(_ position: ActionPosition) -> some View {
		let action =
			position == .center
			? centerAction : position == .trailing ? trailingAction : leadingAction

		Image(systemName: action.symbol)
			.font(.title2)
			.fontWeight(.semibold)
			.opacity(scaleEffect ? 0 : 1)
			.animation(.linear(duration: 0.05), value: scaleEffect)
			.frame(width: 60, height: 60)
			.background {
				if activePosition == position {
					ZStack {
						Rectangle()
							.fill(.background)

						Rectangle()
							.fill(.gray.opacity(0.2))
					}
					.clipShape(.rect(cornerRadius: scaleEffect ? 0 : 30))
					.compositingGroup()
					.matchedGeometryEffect(id: "INDICATOR", in: animation)
					.scaleEffect(scaleEffect ? 20 : 1, anchor: .bottom)
				}
			}
			.frame(maxWidth: .infinity)
			.compositingGroup()
			.animation(.easeInOut(duration: 0.25), value: activePosition)
	}

	private enum ActionPosition: Int, CaseIterable {
		case leading = -1
		case center = 0
		case trailing = 1
	}
}

struct PullEffectAction {
	var symbol: String
	/// MORE PROPERTIES HERE
	var action: () -> Void
}
