import PhotosUI
import SwiftUI

struct ContentView: View {
    @StateObject private var photoStore = PhotoStore()
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var newImageData: Data?
    @State private var newImageName = ""
    @State private var showingNamePrompt = false
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker("Import Photo", selection: $selectedItem, matching: .images)
                    .padding()
                
                List {
                    ForEach(photoStore.photos) { photo in
                        NavigationLink(destination: DetailView(photo: photo)) {
                            HStack {
                                if let uiImage = UIImage(data: photo.imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                Text(photo.name)
                            }
                        }
                    }
                }
                .navigationTitle("My Photos")
            }
        }
        .onChange(of: selectedItem) {
            Task {
                await handlePickedItem(selectedItem)
            }
        }
        .alert("Name this photo", isPresented: $showingNamePrompt) {
            TextField("Photo name", text: $newImageName)
            Button("Save") {
                if let imageData = newImageData {
                    photoStore.addPhoto(name: newImageName, imageData: imageData)
                    newImageName = ""
                }
            }
            Button("Cancel", role: .cancel) {
                newImageName = ""
            }
        }
    }
    
    func handlePickedItem(_ item: PhotosPickerItem?) async {
        guard let item else { return }
        if let data = try? await item.loadTransferable(type: Data.self) {
            await MainActor.run {
                newImageData = data
                showingNamePrompt = true
            }
        }
    }
}

#Preview {
    ContentView()
}
