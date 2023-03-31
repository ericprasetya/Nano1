//
//  CardView.swift
//  Nano1
//
//  Created by Randy Julian on 21/03/23.
//

import SwiftUI

struct CardBack : View{
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    @Binding var product: LostItem
    
    var body: some View{
        ZStack{
            Image("cardBg")
                .cornerRadius(15)
                .frame(width: width, height: height)
                .shadow(radius: 10)

            VStack {
                HStack {
                    if product.imageName != nil {
                        Image(uiImage: UIImage(contentsOfFile: product.imageName!.path) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .clipped()
                            .cornerRadius(10)
                            .foregroundColor(.blue.opacity(0.7))
                            .offset(x:31.5)
                        
                    } else if product.localImage != nil {
                        Image(product.localImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .clipped()
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .offset(x:31.5)
                    } else {
                        Image(systemName: "nosign.app.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .clipped()
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .offset(x:31.5)
                    }
                        

                    VStack {
                        
                            
                        HStack {
                            Text(product.name)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                                .padding(.bottom, 5)
                                .font(.title3)
                            Spacer()
                        }
                        
                        HStack {
                            Text(product.category.name)
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                                .padding(.bottom, 5)
                            Spacer()
                        }
                        
                        HStack {
                            Text(product.date.formatted(date: .numeric, time: .omitted))
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                                .padding(.bottom, 5)
                                .padding(.trailing, 2)
                            
                            Text("|")
                                .padding(.bottom, 7)
                                .font(.title2)
                                .foregroundColor(.white)

                            
                            Text(product.date.formatted(date: .omitted, time: .shortened))
                                .foregroundColor(.white)
                                .padding(.leading, 2)
                                .padding(.bottom, 5)
                            
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardFront : View{
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    @Binding var product: LostItem
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "2886D8"))
                .frame(width: width, height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "2FA3EB"))
                        .frame(width: width, height: 120
                        )
                        .offset(y:-20))
                
            
            VStack{
                
                HStack {
                    Text("Description:")
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                        .padding(.leading, 22)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(width: width)
                
                Text(product.description)
                    .lineLimit(3)
                    .frame(width: 300, height: 70)
                    .foregroundColor(.white)
                
                HStack {
//                    Spacer()
                    Image(systemName: "phone")
                        .foregroundColor(.white)
                    Text(product.owner?.phoneNumber ?? "phone")
                        .fontWeight(.bold)
                        .font(.caption)
                        .foregroundColor(.white)
//                        .padding(.trailing, 22)
                    Spacer()
                    Image(systemName: "location")
                        .foregroundColor(.white)
                    Text(product.location)
                        .fontWeight(.bold)
                        .font(.caption)
                        .lineLimit(2)
                        .foregroundColor(.white)
//                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 5)
                .frame(width: width)
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    @State var product: LostItem
    
    let width : CGFloat = 340
    let height : CGFloat = 160
    let durationAndDelay : CGFloat = 0.35
    
    func flipCard(){
        isFlipped = !isFlipped
        if isFlipped{
            withAnimation(.linear(duration: durationAndDelay)){
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else{
            withAnimation(.linear(duration: durationAndDelay)){
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        ZStack{
            CardFront(width: width, height: height, degree: $frontDegree, product: $product)
            CardBack(width: width, height: height, degree: $backDegree, product: $product)
        }.onTapGesture {
            flipCard()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(product: LostItem(name: "test", description: "test", location: "test", date: .now, category: Category(name: "test"), owner: Owner(phoneNumber: "081222222222",    password: "000")))
    }
}
