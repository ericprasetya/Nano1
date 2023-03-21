//
//  ContentView.swift
//  Nano1
//
//  Created by Randy Julian on 19/03/23.
//

import SwiftUI

struct ContentView: View {
    @State var phoneNumber: String = "+62"
    @State private var action: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                    VStack {
                        Text("iFound")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        Text("did u lose something?")
                            .font(.body)
                            .foregroundColor(.gray)
                            .italic()
                        Spacer()
                    }
                    
                    ZStack{
                        Image("1")
                            .resizable()
                            .frame(width: 500.0, height: 500.0)
                            .offset(y:200)

                        VStack {
                            HStack{
                                Text("Enter your Phone Number")
                                    .font(.subheadline)
                                    .padding(.top, 30)
                                Spacer()
                            }
                            TextField("Phone Number", text: $phoneNumber)
                                .padding(.all)
                                .frame(height: 45)
                                .background(.thinMaterial)
                                .cornerRadius(7)
                                .shadow(radius: 7, x: 5, y: 5)
                            
//                            NavigationLink(destination: HomePageView(), isActive: $action) {
//                                                EmptyView()
//                                            }
                                Button {
                                    self.action.toggle()
                                } label: {
                                    Text("Continue")
                                        .frame(width: 330, height: 30)
                                }
                                .padding(.top, 15)
                                .buttonBorderShape(.roundedRectangle)
                                .buttonStyle(.borderedProminent)
                                
//                            }
                        }
                        .frame(width: 350.0)
                        
                    }
                }
            .padding()
            .navigationDestination(isPresented: $action){
                HomePageView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
