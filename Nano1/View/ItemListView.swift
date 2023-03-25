//
//  ItemListView.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 22/03/23.
//

import SwiftUI

struct ItemListView: View {
    
    @EnvironmentObject var modelData: ModelData
    @Binding var search: String
    @Binding var selectedCategoryID: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(filteredItems()) { product in
                CardView(product: product)
                    .padding(.top, -15)
            }
            .foregroundColor(.black)
        }
    }
    
    func filteredItems() -> [LostItem] {
        var items = modelData.lostItems
        if search != "" {
            items = items.filter{
                $0.name.lowercased().contains(search.lowercased())
            }
        }
        
        if selectedCategoryID != "" {
            items = items.filter{
                $0.category.id.uuidString == selectedCategoryID
            }
        }
        
        
        return items
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
