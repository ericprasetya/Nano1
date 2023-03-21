//
//  Category.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 21/03/23.
//

import Foundation

class Category: Identifiable {
    var id = UUID()
    var name: String = ""
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
