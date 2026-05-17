// by mioe

import SwiftUI

struct ContentView: View {
	@State
	private var tokens = Token.initialTokens

	var body: some View {
		NavigationStack(root: {
			MergeableContainer {
				WrappingHStack(alignment: .leading) {
					ForEach(tokens) { token in
						Button(
							action: {},
							label: {
								Text(textDecorationByEmoji(token.text))
							}
						)
						.labelStyle(.titleAndIcon)
						.buttonStyle(.glass)
						.intelligenceGlow(isActive: token.text == "PenPineappleApplePen")
						.mergeableItem(id: token.id)
					}
					.onMerge { (sourceIndex: Int, destinationIndex: Int) in
						tokens = tokens.merged(sourceIndex, with: destinationIndex) {
							source,
							destination in
							Token(
								text: [source.text, destination.text].joined(separator: "")
							)
						}
					}
				}
			}
			.animation(.default, value: tokens)
			.padding()
			.toolbar {
				ToolbarItem(placement: .destructiveAction) {
					Button("Reset", action: resetTokens)
				}
			}
		})
	}

	private func resetTokens() {
		tokens = Token.initialTokens
	}
	
	private func textDecorationByEmoji(_ t: String) -> String {
		switch(t) {
		case "Pen": return "🖊️ \(t)"
		case "Pineapple": return "🍍 \(t)"
		case "Apple": return "🍎 \(t)"
		case "PenPineapple": return "🖊️🍍 \(t)"
		case "ApplePen": return "🍎🖊️ \(t)"
		case "PenPineappleApplePen": return "🖊️🍍🍎🖊️ \(t) 🕺"
		default: return t
		}
	}
}

struct Token: Identifiable, Hashable {
	let id = UUID()
	var text: String

	static var initialTokens: [Token] {
		[
			Token(text: "Pen"),
			Token(text: "Pineapple"),
			Token(text: "Apple"),
			Token(text: "Pen"),
		]
	}
}

extension Array where Element == Token {
	func merged(
		_ sourceIndex: Int,
		with destinationIndex: Int,
		merge: (Token, Token) -> Token
	) -> [Token] {
		guard
			sourceIndex != destinationIndex,
			indices.contains(sourceIndex),
			indices.contains(destinationIndex),
			abs(sourceIndex - destinationIndex) == 1
		else {
			return self
		}

		let orderedIndices = [sourceIndex, destinationIndex].sorted()
		let mergedElement = merge(self[orderedIndices[0]], self[orderedIndices[1]])
		let insertionIndex = orderedIndices[0]
		let removingIndices = orderedIndices.sorted(by: >)
		var elements = self

		for index in removingIndices {
			elements.remove(at: index)
		}

		elements.insert(mergedElement, at: insertionIndex)
		return elements
	}
}

private struct WrappingHStack: Layout {
	var alignment: HorizontalAlignment = .center
	var horizontalSpacing: CGFloat = 8
	var verticalSpacing: CGFloat = 8

	func sizeThatFits(
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout ()
	) -> CGSize {
		let rows = rows(for: proposal, subviews: subviews)
		return CGSize(
			width: proposal.width ?? rows.map(\.size.width).max() ?? 0,
			height: rows.reduce(0) { height, row in
				height + row.size.height
			} + verticalSpacing * CGFloat(max(rows.count - 1, 0))
		)
	}

	func placeSubviews(
		in bounds: CGRect,
		proposal: ProposedViewSize,
		subviews: Subviews,
		cache: inout ()
	) {
		let rows = rows(for: proposal, subviews: subviews)
		var y = bounds.minY

		for row in rows {
			var x = xOffset(for: row, in: bounds)

			for element in row.elements {
				let point = CGPoint(
					x: x,
					y: y + (row.size.height - element.size.height) / 2
				)

				subviews[element.index].place(
					at: point,
					anchor: .topLeading,
					proposal: ProposedViewSize(element.size)
				)

				x += element.size.width + horizontalSpacing
			}

			y += row.size.height + verticalSpacing
		}
	}

	private func rows(
		for proposal: ProposedViewSize,
		subviews: Subviews
	) -> [Row] {
		let availableWidth = proposal.width ?? .infinity
		var rows: [Row] = []
		var currentRow = Row()

		for index in subviews.indices {
			let size = subviews[index].sizeThatFits(.unspecified)
			let element = Element(index: index, size: size)
			let nextWidth =
				currentRow.size.width
				+ (currentRow.elements.isEmpty ? 0 : horizontalSpacing) + size.width

			if nextWidth > availableWidth, currentRow.elements.isEmpty == false {
				rows.append(currentRow)
				currentRow = Row(element)
			} else {
				currentRow.append(element, spacing: horizontalSpacing)
			}
		}

		if currentRow.elements.isEmpty == false {
			rows.append(currentRow)
		}

		return rows
	}

	private func xOffset(for row: Row, in bounds: CGRect) -> CGFloat {
		switch alignment {
		case .leading:
			bounds.minX
		case .trailing:
			bounds.maxX - row.size.width
		default:
			bounds.midX - row.size.width / 2
		}
	}

	private struct Row {
		var elements: [Element] = []
		var size: CGSize = .zero

		init() {}

		init(_ element: Element) {
			elements = [element]
			size = element.size
		}

		mutating func append(_ element: Element, spacing: CGFloat) {
			size.width += (elements.isEmpty ? 0 : spacing) + element.size.width
			size.height = max(size.height, element.size.height)
			elements.append(element)
		}
	}

	private struct Element {
		let index: Int
		let size: CGSize
	}
}

struct IntelligenceGlow<S: InsettableShape>: ViewModifier {
	var isActive: Bool
	var shape: S
	
	@State private var stops: [Gradient.Stop] = IntelligenceGlow.makeStops()
	
	private static var palette: [Color] {
		[
			Color(red: 0.74, green: 0.51, blue: 0.95),
			Color(red: 0.96, green: 0.73, blue: 0.92),
			Color(red: 0.55, green: 0.62, blue: 1.00),
			Color(red: 1.00, green: 0.40, blue: 0.47),
			Color(red: 1.00, green: 0.73, blue: 0.44),
			Color(red: 0.78, green: 0.53, blue: 1.00),
		]
	}
	
	static func makeStops() -> [Gradient.Stop] {
		palette
			.map { Gradient.Stop(color: $0, location: .random(in: 0...1)) }
			.sorted { $0.location < $1.location }
	}
	
	func body(content: Content) -> some View {
		content
			.overlay {
				glow
					.opacity(isActive ? 1 : 0)
					.animation(.easeInOut(duration: 0.35), value: isActive)
					.allowsHitTesting(false)
			}
		// таймер крутится только пока активно — без нагрузки в простое
			.task(id: isActive) {
				guard isActive else { return }
				while !Task.isCancelled {
					try? await Task.sleep(for: .milliseconds(280))
					withAnimation(.easeInOut(duration: 0.6)) {
						stops = Self.makeStops()
					}
				}
			}
	}
	
	private var glow: some View {
		let gradient = AngularGradient(stops: stops, center: .center)
		return ZStack {
			shape.stroke(gradient, lineWidth: 6).blur(radius: 8)   // внешнее свечение
			shape.stroke(gradient, lineWidth: 3).blur(radius: 2)   // средний слой
			shape.stroke(gradient, lineWidth: 1.25)                // чёткая кромка
		}
	}
}

extension View {
	func intelligenceGlow<S: InsettableShape>(
		isActive: Bool,
		in shape: S = Capsule()
	) -> some View {
		modifier(IntelligenceGlow(isActive: isActive, shape: shape))
	}
}
