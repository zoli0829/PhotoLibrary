//
//  DetailView.swift
//  PhotoLibrary
//
//  Created by Zoltan Vegh on 15/05/2025.
//

import SwiftUI

struct DetailView: View {
    let photo: PhotoItem
    
    @StateObject private var locationFetcher = LocationFetcher()
    @State private var userLocation = "Location unknown"
    
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
            
            Text(userLocation)
                .padding()

            Button("Read Location") {
                if let location = locationFetcher.lastKnownPosition {
                    userLocation = "Your location is \(location)"
                } else {
                    userLocation = "Your location is unknown"
                }
            }
            
            Text(userLocation)
        }
        .navigationTitle(photo.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            locationFetcher.start()
        }
    }
}


#Preview {
    DetailView(photo: PhotoItem(id: UUID(), name: "Test Photo", imageData: Data()))
}
