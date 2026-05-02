// by mioe

import SwiftUI

struct ContentView: View {
	@State var isShowAlert: Bool = false
	@State var isShowSheet: Bool = false
	@State var isShowWave: Bool = false
	@State var topPanelSelected: Option = options[0]
	@State var bottomPanelSelected: Option = options[1]
	@State var topPanelInputValue: String = "300.00"
	@State var bottomPanelInputValue: String = "1.37"

	var body: some View {
		ZStack {
			Image(.mockIphoneWallpaperWave)
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()

			if isShowWave == true {
				VStack(spacing: 56) {
					ForEach(0...10, id: \.self) { _ in
						Rectangle()
							.fill(.black)
							.frame(maxWidth: .infinity)
							.frame(height: 12)
							.ignoresSafeArea()
					}
				}
			}

			ScrollView {
				VStack {
					HStack {
						Button {
							isShowAlert.toggle()
						} label: {
							Label("alert", systemImage: "questionmark.message")
						}
						.buttonStyle(.glass)
						.alert("Alert", isPresented: $isShowAlert) {
							Button("confirm", role: .confirm) {}
							Button("destructive", role: .destructive) {}
							Button("close", role: .close) {}
							Button("cancel", role: .cancel) {}
						} message: {
							Text("message")
						}

						Label("contextMenu (press)", systemImage: "ellipsis")
							.padding(.vertical, 6)
							.padding(.horizontal, 12)
							.glassEffect(.regular.tint(.mint.opacity(0.5)).interactive())
							.contextMenu {
								Button {
									print("onTap: Add to Favorites")
								} label: {
									Label("Add to Favorites", systemImage: "heart")
								}
								Button {
									print("onTap: Show in Maps")
								} label: {
									Label("Show in Maps", systemImage: "mappin")
								}
							}
					}

					HStack {
						Button {
							isShowSheet.toggle()
						} label: {
							Label("sheet", systemImage: "arrow.up.document")
						}
						.buttonStyle(.glassProminent)
						.sheet(isPresented: $isShowSheet) {
							Button("destructive", role: .destructive) { isShowSheet = false }
								.presentationDetents([.medium, .large])
						}

						Button {
							withAnimation {
								isShowWave.toggle()
							}
						} label: {
							Label("show wave", systemImage: "water.waves")
						}
						.buttonStyle(.glass)
					}

					VStack {
						Text("modifier").modifier(SecondaryTextStyle())
						Text("modifier via extension").setSecondary()
					}
					.padding(16)

					ZStack {
						VStack {
							TopPanelView()
							BottomPanelView()
						}

						VStack {
							HStack {
								Text("Half")
									.font(.system(size: 10))
									.frame(width: 40, height: 28)
									.glassEffect(.regular.tint(.orange).interactive())
									.onTapGesture {
										topPanelInputValue = "6,394.28"
									}

								Text("Max")
									.font(.system(size: 10))
									.frame(width: 40, height: 28)
									.glassEffect(.regular.tint(.purple).interactive())
									.onTapGesture {
										topPanelInputValue = "12,788.56"
									}
							}
							.padding(.top, 8)

							Spacer()

							Button {
								print("onTap: refresh")
							} label: {
								Image(systemName: "arrow.up.arrow.down")
									.font(.system(size: 24))
									.padding(16)
							}
							.buttonStyle(.glass)
							.buttonBorderShape(.circle)
							.zIndex(1)

							Spacer()

							HStack {
								Menu {
									Button("todo") {}
									Button("todo", role: .destructive) {}
								} label: {
									HStack(spacing: 4) {
										Text("Overview")
										Image(systemName: "chevron.down")
									}
									.font(.system(size: 10))
									.frame(width: 84, height: 28)
									.foregroundStyle(.white.opacity(0.75))
									.glassEffect(.regular.tint(.black).interactive())
								}
							}
							.padding(.bottom, 8)
						}
					}

				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
			.padding(32)
		}
		.background(.black)
	}

	@ViewBuilder
	private func TopPanelView() -> some View {
		Button {
			print("onTap: TopPanelView")
		} label: {
			CardView(
				color: .primary,
				selected: $topPanelSelected,
				inputValue: $topPanelInputValue,
				isTop: true,
				balance: "12,788.56",
				topLabel: "You Pay"
			)
			.frame(width: 344, height: 160)
			.glassEffect(
				.regular.tint(.mint.opacity(0.5)).interactive(),
				in: CustomShape()
			)
		}
		.buttonStyle(.plain)
	}

	@ViewBuilder
	private func BottomPanelView() -> some View {
		Button {
			print("onTap: BottomPanelView")
		} label: {
			CardView(
				color: .white,
				selected: $bottomPanelSelected,
				inputValue: $bottomPanelInputValue,
				isTop: false,
				balance: "24.56",
				topLabel: "You Get"
			)
			.frame(width: 344, height: 160)
			.glassEffect(
				.regular.tint(.black).interactive(),
				in: CustomShape(flipped: true)
			)
		}
		.buttonStyle(.plain)
	}
}

struct SecondaryTextStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.system(size: 12, weight: .medium, design: .monospaced))
			.foregroundStyle(.white)
	}
}

extension Text {
	func setSecondary() -> some View {
		self
			.modifier(SecondaryTextStyle())
	}
}
