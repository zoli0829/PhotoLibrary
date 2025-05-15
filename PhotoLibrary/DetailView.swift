//
//  DetailView.swift
//  PhotoLibrary
//
//  Created by Zoltan Vegh on 15/05/2025.
//

import SwiftUI

struct DetailView: View {
    let photo: PhotoItem
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(data: photo.imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            Text(photo.name)
                .font(.title)
                .padding()
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(photo: PhotoItem(id: UUID(), name: "Test", imageData: Data()))
}
