//
//  Nano1App.swift
//  Nano1
//
//  Created by Randy Julian on 19/03/23.
//

import SwiftUI

@main
struct Nano1App: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
