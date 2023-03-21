//
//  HomePageView.swift
//  Nano1
//
//  Created by Randy Julian on 20/03/23.
//

import SwiftUI

struct HomePageView: View {
    @State private var idx = 0
    @State var categories = [
        Category(name: "Electronic"),
        Category(name: "Personal Stuff"),
        Category(name: "Stationary"),
    ]
    
    @State var selectedCategoryID: String?
    
    var body: some View {
        VStack{
            HStack{
                Text("Hello, how’s your day?")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(categories) { category in
                        Button(action: {
                            selectedCategoryID = category.id.uuidString
                        }) {

                        Text(category.name)
                            .font(.system(size: 20))
                            .bold()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(category.id.uuidString == selectedCategoryID  ? .gray : .blue)
                        .cornerRadius(20)
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding(.top, -4)
            .padding(.leading, 12)
            
            
            Spacer()
        }
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
