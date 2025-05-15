//
//  PhotoStore.swift
//  PhotoLibrary
//
//  Created by Zoltan Vegh on 15/05/2025.
//

import Foundation
import SwiftUI

@MainActor
class PhotoStore: ObservableObject {
    @Published var photos: [PhotoItem] = []
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("photos.json")
    
    init() {
        loadPhotos()
    }
    
    func addPhoto(name: String, imageData: Data) {
        let newPhoto = PhotoItem(id: UUID(), name: name, imageData: imageData)
        photos.append(newPhoto)
        photos.sort()
        savePhotos()
    }
    
    func loadPhotos() {
        do {
            let data = try Data(contentsOf: savePath)
            photos = try JSONDecoder().decode([PhotoItem].self, from: data)
        } catch {
            photos = []
        }
    }
    
    func savePhotos() {
        do {
            let data = try JSONEncoder().encode(photos)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to save photos: \(error.localizedDescription)")
        }
    }
}
