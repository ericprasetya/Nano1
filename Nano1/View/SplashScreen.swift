//
//  SplashScreen.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 26/03/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var animate = false
    @State var isActive = true
    @Namespace var logo
    var body: some View {
        if isActive == true{
            
            ZStack {
                VStack{
                    ZStack{
                        if animate == false {
                            Image("locationLogo")
                                .resizable()
                                .matchedGeometryEffect(id: "logo", in: logo)
                                .frame(width: 1000, height: 1500)
                                .background(Color(hex: "F0AE5A"))
                        }
                        Image("locationLogo")
                            .resizable()
                            .matchedGeometryEffect(id: "logo", in: logo)
                            .scaledToFit()
                            .frame(width: 100)
                        Image("searchLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .offset(y: animate == false ? -600 : 0)
                    }
                    .padding(.top, 98)
                    Spacer()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    animate.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    self.isActive = false
                }
            }
            .animation(.interactiveSpring(response: 1.8, dampingFraction: 0.8, blendDuration: 0.5) , value: animate)
        } else {
//            ContentView()
//                .environmentObject(ModelData())
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
//        ContentView()
//            .environmentObject(ModelData())
//        ContentView()
    }
}
