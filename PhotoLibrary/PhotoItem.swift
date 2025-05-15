//
//  PhotoItem.swift
//  PhotoLibrary
//
//  Created by Zoltan Vegh on 15/05/2025.
//

import Foundation
import SwiftUI

struct PhotoItem: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    var imageData: Data
    
    static func < (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        return lhs.name < rhs.name
    }
}
