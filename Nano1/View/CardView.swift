//
//  CardView.swift
//  Nano1
//
//  Created by Eric Prasetya Sentosa on 22/03/23.
//

import SwiftUI

struct CardView: View {
    @State var product: LostItem
    //    var body: some View {
    //        ZStack {
    //
    //            Rectangle()
    //                .cornerRadius(10)
    //                .frame(width: 361, height: 200)
    //                .clipped()
    //                .foregroundColor(Color(hex: "359BA9"))
    //
    //            VStack(alignment: .leading){
    //                Text("Product")
    //                    .padding(.top, 40)
    //                    .padding(.leading, 10)
    //                    .font(.headline)
    //                    .offset(y:10)
    //                Rectangle()
    //                    .cornerRadius(10)
    //                    .frame(width: 361, height: 220)
    //                    .foregroundColor(Color(hex: "B8D3E3"))
    //
    //            }
    //
    //            HStack{
    //                VStack{
    //                    if product.imageName != nil {
    //                        Image(uiImage: UIImage(contentsOfFile: product.imageName!.path) ?? UIImage())
    //                            .resizable()
    //                            .frame(width: 100.0, height: 100.0)
    //                            .cornerRadius(10)
    //                            .padding(10)
    //                    } else {
    //                        Image("1")
    //                            .resizable()
    //                            .frame(width: 100.0, height: 100.0)
    //                            .cornerRadius(10)
    //                            .padding(10)
    //                    }
    //
    //
    //
    //                    Text(product.date.formatted(date: .numeric, time: .shortened))
    //                        .fixedSize(horizontal: false, vertical: true)
    //                        .frame(width: 100)
    //                }
    //
    //                VStack(alignment: .leading){
    //                    Text(product.name)
    //                        .bold()
    //                    Spacer()
    //                    Text("Description: ")
    //                    Text(product.description)
    //                    Spacer()
    //                    Text("Location: ")
    //                    Text(product.location)
    //                    Spacer()
    //            }
    //
    //                Spacer()
    //            }
    //
    //            .frame(width: 361, height: 150)
    //            .padding(.top, 25)
    //            .offset(y:10)
    //            Spacer()
    //
    //        }
    //        .padding(0)
    //
    //    }
        
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let width : CGFloat = 340
    let height : CGFloat = 220
    let durationAndDelay : CGFloat = 0.3
    
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
            CardFront(width: width, height: height, degree: $frontDegree)
            CardBack(width: width, height: height, degree: $backDegree)
        }.onTapGesture {
            flipCard()
        }
    }
    
}
struct CardBack : View{
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .frame(width: width, height: height)
            
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                .foregroundColor(.blue.opacity(0.7))
                
                Text("Nama Item")
                
                Text("Date & Time")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(7)
                    .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(.black), lineWidth: 2))
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardFront : View{
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue.opacity(0.3))
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y:0)

            VStack{
                Text("jdasfasfasklflaksjfklasjfkaskfjaskjflkasjfkjsaflasfjjdasfasfasklflaksjfklasjfkaskfjaskjflkasjfkjsaflasfjjdasfasfasklflaksjfklasjfkaskfjaskjflkasjfkjsaflasfj")
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                
                HStack {
                    Text("Phone Number")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
//                        .background(Color(hex: "123abc"))
                        .padding(7)
                        .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color(.black), lineWidth: 2))
                }
                
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(product:
                    LostItem(name: "test", description: "dafsafdsa as f asfdas f", location: "Outdoor area", date: Date(), category: Category(name: "test1"))
        )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
