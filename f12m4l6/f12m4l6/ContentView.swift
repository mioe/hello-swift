// by mioe

import SwiftUI

struct ContentView: View {

	@StateObject var viewModel = ContentViewModel()

	@State private var editingNoteID: UUID?
	@State private var editName: String = ""
	@State private var editText: String = ""
	@State private var showEditAlert: Bool = false

	var body: some View {
		VStack(spacing: 16) {
			Button {
				viewModel.setNote()
			} label: {
				Text("setNote")
			}

			ScrollView {
				ForEach(viewModel.notes, id: \.id) { note in
					VStack(alignment: .leading, spacing: 8) {
						HStack(alignment: .top, spacing: 16) {
							VStack(alignment: .leading) {
								Text(note.name)
									.font(.title3)
								if let t = note.text {
									Text(t)
								}
							}

							Spacer(minLength: 0)

							HStack(spacing: 8) {
								Button {
									editingNoteID = note.id
									editName = note.name
									editText = note.text ?? ""
									showEditAlert = true
								} label: {
									Text("patch")
								}

								Button {
									viewModel.removeNote(id: note.id)
								} label: {
									Text("remove")
								}
							}
						}
						Divider()
					}
				}
			}
			.scrollClipDisabled()
			.scrollIndicators(.hidden)
		}
		.padding(32)
		.frame(maxWidth: .infinity)
		.onAppear {
			viewModel.getNote()
		}
		.alert("patch note", isPresented: $showEditAlert) {
			TextField("name", text: $editName)
			TextField("text", text: $editText)
			Button("patch") {
				if let id = editingNoteID {
					viewModel.patchNote(id: id, name: editName, text: editText)
				}
			}
			Button("cancel", role: .cancel) {}
		}
	}
}
