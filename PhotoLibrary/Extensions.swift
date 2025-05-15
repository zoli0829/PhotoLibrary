//
//  Extensions.swift
//  PhotoLibrary
//
//  Created by Zoltan Vegh on 15/05/2025.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
