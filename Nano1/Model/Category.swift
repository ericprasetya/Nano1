//
//  Category.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 21/03/23.
//

import Foundation

struct Category: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String = ""
    
    static let CategoryKeyForUserDefaults = "myCategory"
    
    static func saveCategories(_ Categories: [Category]) {
        let data = Categories.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: CategoryKeyForUserDefaults)
    }
    
    static func loadCategories() -> [Category] {
        guard let encodedData = UserDefaults.standard.array(forKey: CategoryKeyForUserDefaults) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(Category.self, from: $0) }
    }
}

