// by mioe

import PhotosUI
import SwiftUI

struct NoteFormView: View {

	let note: Note?
	let onSubmit: (_ name: String, _ content: String, _ images: [Data]) -> Void

	@State private var name = ""
	@State private var content = ""
	@State private var pickerItems: [PhotosPickerItem] = []
	@State private var images: [Data] = []

	private var isEditing: Bool { note != nil }

	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			TextField("Название", text: $name)
				.textFieldStyle(.roundedBorder)

			TextField("Текст", text: $content, axis: .vertical)
				.lineLimit(4, reservesSpace: true)
				.textFieldStyle(.roundedBorder)

			HStack(alignment: .center, spacing: 8) {
				PhotosPicker(selection: $pickerItems, matching: .images) {
					Image(systemName: "plus")
						.font(.title2)
						.foregroundStyle(.secondary)
						.frame(width: 60, height: 60)
						.background(Color(.secondarySystemBackground))
						.clipShape(RoundedRectangle(cornerRadius: 8))
				}

				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 8) {
						ForEach(Array(images.enumerated()), id: \.offset) { index, data in
							thumbnail(data: data, index: index)
						}
					}
				}
			}

			Button(isEditing ? "Сохранить" : "Создать") {
				onSubmit(name, content, images)
				if !isEditing {
					reset()
				}
			}
			.buttonStyle(.borderedProminent)
			.frame(maxWidth: .infinity)
			.disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
		}
		.padding(.horizontal, 32)
		.padding(.vertical, 8)
		.task(id: note?.id) { populate() }
		.onChange(of: pickerItems) { _, newItems in
			guard !newItems.isEmpty else { return }
			Task { await loadPicked(newItems) }
		}
	}

	@ViewBuilder
	private func thumbnail(data: Data, index: Int) -> some View {
		if let uiImage = UIImage(data: data) {
			Image(uiImage: uiImage)
				.resizable()
				.scaledToFill()
				.frame(width: 60, height: 60)
				.clipped()
				.clipShape(RoundedRectangle(cornerRadius: 8))
				.overlay(alignment: .topTrailing) {
					Button {
						images.remove(at: index)
					} label: {
						Image(systemName: "xmark.circle.fill")
							.foregroundStyle(.white, .black.opacity(0.6))
					}
					.padding(2)
				}
		}
	}

	private func populate() {
		if let note {
			name = note.name
			content = note.content ?? ""
			images = note.attachments.array.compactMap { ($0 as? Attachment)?.data }
			pickerItems = []
		} else {
			reset()
		}
	}

	private func reset() {
		name = ""
		content = ""
		images = []
		pickerItems = []
	}

	private func loadPicked(_ items: [PhotosPickerItem]) async {
		var loaded: [Data] = []
		for item in items {
			if let data = try? await item.loadTransferable(type: Data.self) {
				loaded.append(data)
			}
		}
		await MainActor.run {
			images.append(contentsOf: loaded)
			pickerItems = []
		}
	}
}
