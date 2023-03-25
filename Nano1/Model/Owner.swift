//
//  Owner.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 22/03/23.
//

import Foundation

struct Owner: Identifiable, Codable{
    var id = UUID()
    let phoneNumber: String
    
    static let OwnerKeyForUserDefaults = "myOwner"
    
    static func saveOwners(_ Owners: [Owner]) {
        let data = Owners.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: OwnerKeyForUserDefaults)
    }
    
    static func loadOwners() -> [Owner] {
        guard let encodedData = UserDefaults.standard.array(forKey: OwnerKeyForUserDefaults) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(Owner.self, from: $0) }
    }
}

