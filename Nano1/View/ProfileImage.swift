//
//import SwiftUI
//
//struct CardBack : View{
//    let width : CGFloat
//    let height : CGFloat
//    @Binding var degree : Double
//    
//    var body: some View{
//        ZStack{
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(.blue.opacity(0.7), lineWidth: 3)
//                .frame(width: width, height: height)
//            
//            VStack {
//                Image("logo")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                .foregroundColor(.blue.opacity(0.7))
//                
//                Text("Nama Item")
//                
//                Text("Date & Time")
//                    .fontWeight(.bold)
//                    .foregroundColor(.blue)
//                    .padding(7)
//                    .overlay(
//                    RoundedRectangle(cornerRadius: 50)
//                        .stroke(Color(.black), lineWidth: 2))
//            }
//        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
//    }
//}
//
//struct CardFront : View{
//    let width : CGFloat
//    let height : CGFloat
//    @Binding var degree : Double
//    
//    var body: some View{
//        ZStack{
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.blue.opacity(0.3))
//                .frame(width: width, height: height)
//                .shadow(color: .gray, radius: 2, x: 0, y:0)
//
//            VStack{
//                Text("jdasfasfasklflaksjfklasjfkaskfjaskjflkasjfkjsaflasfjjdasfasfasklflaksjfklasjfkaskfjaskjflkasjfkjsaflasfjjdasfasfasklflaksjfklasjfkaskfjaskjflkasjfkjsaflasfj")
//                    .multilineTextAlignment(.center)
//                    .frame(width: 300)
//                
//                HStack {
//                    Text("Phone Number")
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
//                        .padding(7)
//                        .overlay(
//                        RoundedRectangle(cornerRadius: 50)
//                            .stroke(Color(.black), lineWidth: 2))
//                }
//                
//            }
//        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
//    }
//}
//
//struct CardView: View {
//    @State var backDegree = 0.0
//    @State var frontDegree = -90.0
//    @State var isFlipped = false
//    
//    let width : CGFloat = 340
//    let height : CGFloat = 220
//    let durationAndDelay : CGFloat = 0.3
//    
//    func flipCard(){
//        isFlipped = !isFlipped
//        if isFlipped{
//            withAnimation(.linear(duration: durationAndDelay)){
//                backDegree = 90
//            }
//            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
//                frontDegree = 0
//            }
//        } else{
//            withAnimation(.linear(duration: durationAndDelay)){
//                frontDegree = -90
//            }
//            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
//                backDegree = 0
//            }
//        }
//    }
//    
//    var body: some View {
//        ZStack{
//            CardFront(width: width, height: height, degree: $frontDegree)
//            CardBack(width: width, height: height, degree: $backDegree)
//        }.onTapGesture {
//            flipCard()
//        }
//    }
//}
//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
