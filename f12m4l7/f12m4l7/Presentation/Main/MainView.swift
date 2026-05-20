// by mioe

import QuickLook
import SwiftUI

struct MainView: View {

	@StateObject var viewModel = MainViewModel()
	@State private var editingNote: Note?
	@State private var previewURL: IdentifiableURL?

	var body: some View {
		VStack(spacing: 0) {
			ScrollView {
				LazyVStack(spacing: 12) {
					ForEach(viewModel.notes) { note in
						NoteRow(
							note: note,
							isSelected: editingNote?.id == note.id,
							onAttachmentTap: { attachment in
								if let url = makePreviewURL(for: attachment) {
									previewURL = IdentifiableURL(url: url)
								}
							},
							onSelect: { editingNote = note },
							onDelete: { viewModel.deleteNote(note) }
						)
					}
				}
				.padding(32)
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)

			VStack(spacing: 8) {
				Divider()
				if editingNote != nil {
					HStack {
						Text("Редактирование")
							.font(.caption)
							.foregroundStyle(.secondary)
						Spacer()
						Button("Отмена") { editingNote = nil }
							.font(.caption)
					}
					.padding(.horizontal, 32)
				}
				NoteFormView(note: editingNote) { name, content, images in
					if let editingNote {
						viewModel.updateNote(
							editingNote,
							name: name,
							content: content,
							imageDatas: images
						)
					} else {
						viewModel.createNote(
							name: name,
							content: content,
							imageDatas: images
						)
					}
					editingNote = nil
				}
			}
			.frame(maxWidth: .infinity)
			.frame(alignment: .bottom)
			.background(.background)
		}
		.frame(maxWidth: .infinity)
		.sheet(item: $previewURL) { item in
			QuickLookPreview(url: item.url)
				.ignoresSafeArea()
		}
		.onAppear { viewModel.getNotes() }
	}

	private func makePreviewURL(for attachment: Attachment) -> URL? {
		guard let data = attachment.data else { return nil }
		let url = FileManager.default.temporaryDirectory
			.appendingPathComponent("\(attachment.id.uuidString).jpg")
		do {
			try data.write(to: url)
			return url
		} catch {
			print("Failed to write preview file: \(error)")
			return nil
		}
	}
}

private struct NoteRow: View {

	let note: Note
	let isSelected: Bool
	let onAttachmentTap: (Attachment) -> Void
	let onSelect: () -> Void
	let onDelete: () -> Void

	private var attachments: [Attachment] {
		note.attachments.array.compactMap { $0 as? Attachment }
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			HStack(alignment: .top) {
				VStack(alignment: .leading, spacing: 4) {
					Text(note.name)
						.font(.headline)
					if let content = note.content, !content.isEmpty {
						Text(content)
							.font(.body)
							.foregroundStyle(.secondary)
							.lineLimit(4)
					}
				}
				Spacer()
				Menu {
					Button("Редактировать", action: onSelect)
					Button("Удалить", role: .destructive, action: onDelete)
				} label: {
					Image(systemName: "ellipsis")
						.padding(8)
						.contentShape(Rectangle())
				}
			}

			if !attachments.isEmpty {
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 8) {
						ForEach(attachments) { attachment in
							if let data = attachment.data,
								let uiImage = UIImage(data: data)
							{
								Image(uiImage: uiImage)
									.resizable()
									.scaledToFill()
									.frame(width: 60, height: 60)
									.clipped()
									.clipShape(RoundedRectangle(cornerRadius: 8))
									.onTapGesture { onAttachmentTap(attachment) }
							}
						}
					}
				}
			}
		}
		.padding(12)
		.background(
			RoundedRectangle(cornerRadius: 12)
				.fill(
					isSelected
						? Color.accentColor.opacity(0.12)
						: Color(.secondarySystemBackground)
				)
		)
	}
}

private struct IdentifiableURL: Identifiable {
	let url: URL
	var id: URL { url }
}

private struct QuickLookPreview: UIViewControllerRepresentable {

	let url: URL

	func makeUIViewController(context: Context) -> QLPreviewController {
		let controller = QLPreviewController()
		controller.dataSource = context.coordinator
		return controller
	}

	func updateUIViewController(
		_ uiViewController: QLPreviewController,
		context: Context
	) {
		context.coordinator.url = url
		uiViewController.reloadData()
	}

	func makeCoordinator() -> Coordinator {
		Coordinator(url: url)
	}

	final class Coordinator: NSObject, QLPreviewControllerDataSource {

		var url: URL

		init(url: URL) {
			self.url = url
		}

		func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
			1
		}

		func previewController(
			_ controller: QLPreviewController,
			previewItemAt index: Int
		) -> QLPreviewItem {
			url as NSURL
		}
	}
}
