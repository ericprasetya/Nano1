//
//  LostItem.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 21/03/23.
//

import Foundation
import SwiftUI

struct LostItem: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var location: String
    var date: Date
    var category: Category
    var owner: Owner?
    var imageName: URL?
    var localImage: String?
//    var image: Image? {
//        Image(uiImage: UIImage(contentsOfFile: imageName!.path) ?? UIImage())
//    }
    static let ItemKeyForUserDefaults = "myItem"
    
    static func saveItems(_ items: [LostItem]) {
        let data = items.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: ItemKeyForUserDefaults)
    }
    
    static func loadItems() -> [LostItem] {
        guard let encodedData = UserDefaults.standard.array(forKey: ItemKeyForUserDefaults) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(LostItem.self, from: $0) }
    }
}

