//
//  ModelData.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 23/03/23.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var owners:[Owner] = Owner.loadOwners();
    @Published var lostItems:[LostItem] = LostItem.loadItems();
    @Published var categories:[Category] = Category.loadCategories();
}
