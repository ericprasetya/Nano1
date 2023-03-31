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
    @Binding var loggedInUser: Owner?
    var body: some View {
        VStack(spacing: 15) {
            ForEach(filteredItems()) { item in
                ZStack{
                    CardView(product: item)
//                    Text(loggedInUser?.phoneNumber ?? "test")
                    if loggedInUser != nil {
                        if item.owner?.phoneNumber == loggedInUser?.phoneNumber {
                            HStack{
                                Spacer()
                                Button {
                                    removeItem(rmItem: item)
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .background {
                                            Circle()
                                                .foregroundColor(.white)
                                        }
                                }
                            }
                            .padding(.bottom, 140)
                            .padding(.trailing, 10)
                        }
                    }
                }
            }
        }
    }
    func removeItem(rmItem: LostItem) {
        if let index = modelData.lostItems.firstIndex(where: {$0.id.uuidString == rmItem.id.uuidString}){
            modelData.lostItems.remove(at: index)
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
