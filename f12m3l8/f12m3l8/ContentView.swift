// by mioe

import SwiftUI

struct ContentView: View {
	@State var inputValue: String = ""
	@State var searchValue: String = ""
	@State var toggleValue: Bool = false

	var body: some View {
		NavigationStack {
			ScrollView {
				VStack {
					NavigationLink {
						AnotherView()
					} label: {
						Text("to AnotherView")
					}

					TextField("input", text: $inputValue)
						.onSubmit {
							print(inputValue)
						}

					if #available(iOS 17.0, *) {
						Toggle("iOS > 17", isOn: $toggleValue)
							.onChange(of: toggleValue) { oldVal, newVal in
								print("oldVal: \(oldVal) | newVal: \(newVal)")
							}
					} else {
						Toggle("iOS < 17", isOn: $toggleValue)
							.onChange(of: toggleValue) { val in
								print("only newVal: \(val)")
							}
					}
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
			.padding(32)
			.refreshable(action: {
				print("refreshable")
			})
			.onAppear {
				print("onAppear - vue:mounted")
			}
			.searchable(text: $searchValue)
			.onSubmit(of: .search) {
				print(searchValue)
			}
		}
	}
}

struct AnotherView: View {
	@State var headerOpacity: CGFloat = 0

	var body: some View {
		ZStack(alignment: .top) {
			HStack {
				Text("Header")
					.padding(16)
					.foregroundStyle(.white)
			}
			.frame(maxWidth: .infinity)
			.background(.mint)
			.zIndex(1)
			.opacity(headerOpacity)
			
			ScrollView {
				VStack {
					GeometryReader { proxy in
						let minY = proxy.frame(in: .global).minY
						ZStack {
							Text("AnotherView | minY: \(minY)")
								.frame(maxWidth: .infinity)
						}
						.frame(width: proxy.size.width)
						.frame(height: 200 + (minY > 0 ? minY : 0))
						.offset(y: -minY < 0 ? -minY : 0)
						.background(.orange.opacity(0.5))
						.onChange(of: minY) { _, newVal in
							headerOpacity = -newVal / 400
						}
					}
					.frame(height: 200)
					
					
					VStack {
						ForEach(0...200, id: \.self) { item in
							Rectangle()
								.frame(height: 50)
								.foregroundStyle(.yellow.opacity(0.5))
								.overlay {
									Text("\(item)")
								}
								.clipShape(Rectangle())
								.onTapGesture {
									print("onTap: \(item)")
								}
						}
					}
				}
			}
			.ignoresSafeArea(edges: .top)
		}
		.onDisappear {
			print("onDisappear - vue:unmounted")
		}
	}
}
