// by mioe

import SwiftUI

struct ContentView: View {
	@State var search = ""

	var body: some View {
		ZStack(alignment: .top) {
			HeaderView()
				.zIndex(1)

			ScrollView {
				VStack(spacing: 24) {
					SearchView(promt: $search)
					CardView(
						title: "Nacoa Apartment",
						subtitle: "Alexander City, Alabama.",
						image: "img-1",
						rate: "4.7",
						price: 1599,
						st1: 5,
						st2: 3,
						st3: 850
					)
					CardView(
						title: "Duplex Apartment",
						subtitle: "Harbor Freeway, Los Angeles.",
						image: "img-2",
						rate: "4.9",
						price: 750,
						st1: 5,
						st2: 3,
						st3: 750
					)
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
			.padding(.top, 48 + 32)
		}
		.padding(.top, 32)
		.padding(.horizontal, 32)
	}

	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			Button {
				print("onTap: back")
			} label: {
				Image(systemName: "chevron.backward")
					.foregroundStyle(.sGreyDark)
					.frame(width: 48, height: 48)
					.background(.sGreySoft1)
					.clipShape(Circle())
					.shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
			}
			.buttonStyle(.plain)

			Spacer()

			Button {
				print("onTap: more")
			} label: {
				Image(systemName: "ellipsis")
					.foregroundStyle(.sF12M3L2Accent)
					.frame(width: 40, height: 40)
					.background(.background)
					.clipShape(RoundedRectangle(cornerRadius: 12))
					.overlay {
						RoundedRectangle(cornerRadius: 12)
							.strokeBorder(.sGreySoft2, lineWidth: 1)
					}
			}
			.buttonStyle(.plain)
		}
	}

	@ViewBuilder
	private func SearchView(promt: Binding<String>) -> some View {
		HStack(spacing: 16) {
			Image(systemName: "magnifyingglass")
				.foregroundStyle(.sGreyDark)

			TextField("Search House, Apartment, etc", text: promt)
				.textFieldStyle(.plain)
				.frame(maxWidth: .infinity)

			Divider()

			Button {
				print("onTap: voice")
			} label: {
				Image(systemName: "mic")
					.foregroundStyle(.sGreyBarelyMedium)
			}
			.buttonStyle(.plain)
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 16)
		.frame(height: 70)
		.background(.sGreySoft1)
		.clipShape(RoundedRectangle(cornerRadius: 24))
	}

	@ViewBuilder
	private func CardView(
		title: String,
		subtitle: String,
		image: String,
		rate: String,
		price: Int,
		st1: Int,
		st2: Int,
		st3: Int
	) -> some View {
		Button {
			print("onTap: card")
		} label: {
			HStack(spacing: 24) {
				ZStack {
					Image(image)
						.resizable()
						.scaledToFill()
					VStack {
						HStack {
							Spacer()
							Button {
								print("onTap: bookmark")
							} label: {
								VStack {
									Image(systemName: "bookmark.fill")
										.font(.system(size: 8))
										.foregroundStyle(.white)
								}
								.frame(width: 16, height: 16)
								.background(
									Color(red: 1.0, green: 0.976, blue: 0.976, opacity: 0.5)
								)
								.clipShape(RoundedRectangle(cornerRadius: 6))
								.overlay {
									RoundedRectangle(cornerRadius: 6)
										.strokeBorder(.white, lineWidth: 1)
								}
							}
						}
						Spacer()
					}
					.padding(.all, 12)
					.frame(width: 104, height: 104)
				}
				.frame(width: 104, height: 104)
				.clipShape(RoundedRectangle(cornerRadius: 24))
				
				VStack(alignment: .leading, spacing: 0) {
					HStack {
						Text(title)
							.font(.system(size: 16, weight: .medium))
						Spacer()
					}
					
					Spacer()
					
					HStack(spacing: 4) {
						Image(systemName: "mappin.and.ellipse")
							.font(.system(size: 10))
							.foregroundStyle(.sF12M3L2Accent)
						Text(subtitle)
							.font(.system(size: 10))
							.foregroundStyle(.secondary)
					}
					
					Spacer()
					
					HStack(spacing: 16) {
						CardStIndicatorView(icon: "bed.double", val: st1)
						CardStIndicatorView(icon: "tray", val: st2)
						CardStIndicatorView(icon: "building.2", val: st3)
					}
					
					Spacer()
					
					HStack {
						HStack(alignment: .bottom, spacing: 0) {
							Text("$\(price)")
								.font(.system(size: 16, weight: .medium))
								.foregroundStyle(.sF12M3L2Accent)
							Text("/mo")
								.font(.system(size: 10))
								.foregroundStyle(Color(red: 0.8, green: 0.8, blue: 0.8))
								.padding(.bottom, 2)
						}
						
						Spacer()
						
						HStack(spacing: 4) {
							Image(systemName: "star.fill")
								.font(.system(size: 12))
								.foregroundStyle(.yellow)
							Text(rate)
								.font(.system(size: 10, weight: .medium))
						}
					}
				}
				.padding(.trailing, 12)
				.padding(.vertical, 4)
			}
			.padding(.all, 12)
			.background(.white)
			.clipShape(RoundedRectangle(cornerRadius: 32))
			.overlay {
				RoundedRectangle(cornerRadius: 32)
					.strokeBorder(.sF12M3L2Eeeeee, lineWidth: 1)
			}
		}
		.buttonStyle(.plain)
	}

	@ViewBuilder
	private func CardStIndicatorView(icon: String, val: Int) -> some View {
		HStack(spacing: 4) {
			Image(systemName: icon)
				.foregroundStyle(.secondary)
			Text("\(val)")
		}
		.font(.system(size: 10, weight: .medium))
	}
}
