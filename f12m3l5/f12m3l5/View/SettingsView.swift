// by mioe

import SwiftData
import SwiftUI

struct SettingsView: View {

	@Environment(AppRouter.self) private var router

	@Query(sort: \Changelog.createdAt, order: .reverse)
	private var changelogs: [Changelog]

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 32) {
				CustomNavigationView(title: "Settings") {
					CustomNavigationItemView(
						icon: "house",
						onTap: { handleOpenHomeView() }
					)
				}
				ChangelogView()
			}
		}
		.scrollClipDisabled()
		.scrollIndicators(.hidden)
		.padding(.horizontal, 32)
		.padding(.top, 20)
		.padding(.bottom, 64)
	}

	@ViewBuilder
	private func ChangelogView() -> some View {
		VStack(alignment: .leading, spacing: 16) {
			VStack(alignment: .leading, spacing: 4) {
				SectionTitleView(title: "Changelog")
				Text("* для изменения флага уведомления кликни на него")
					.iAWritterQuattroS(10)
					.foregroundStyle(.sPrimary)
			}

			VStack(spacing: 12) {
				ForEach(changelogs, id: \.id) { entry in
					ChangelogRowView(entry: entry)
				}
			}
		}
	}

	@ViewBuilder
	private func ChangelogRowView(entry: Changelog) -> some View {
		Button {
			entry.isViewed.toggle()
		} label: {
			HStack(alignment: .top, spacing: 12) {
				ZStack(alignment: .topTrailing) {
					Image(systemName: iconName(for: entry.type))
						.font(.system(size: 16, weight: .medium))
						.foregroundStyle(.sAccent)
						.frame(width: 36, height: 36)
						.background(.sSecondary)
						.clipShape(.rect(cornerRadius: 10))

					if entry.isViewed == false {
						Circle()
							.fill(.white)
							.frame(width: 18, height: 18)
							.overlay {
								Circle()
									.fill(.sSecondary)
									.frame(width: 12, height: 12)
							}
							.offset(x: 8, y: -8)
					}
				}

				VStack(alignment: .leading, spacing: 6) {
					Text(entry.title)
						.lora(14)
						.foregroundStyle(.sPrimary)

					Text(entry.info)
						.iAWritterQuattroS(12)
						.foregroundStyle(.sPrimary.opacity(0.8))
						.multilineTextAlignment(.leading)
						.fixedSize(horizontal: false, vertical: true)

					Text(entry.createdAt, style: .date)
						.iAWritterQuattroS(10)
						.foregroundStyle(.sPrimary.opacity(0.5))
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
		.buttonStyle(.plain)
	}

	private func iconName(for type: ChangelogType) -> String {
		switch type {
		case .feat: "sparkles"
		case .fix: "wrench.adjustable"
		}
	}

	private func handleOpenHomeView() {
		router.currentTab = .home
	}
}
