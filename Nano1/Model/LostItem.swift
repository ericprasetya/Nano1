//
//  LostItem.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 21/03/23.
//

import Foundation
import SwiftUI

struct LostItem: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var description: String
    var location: String
    var category: [String]
    
    var imageName: String
    var image: Image{
        Image(imageName)
    }
}
