//
//  ContentView.swift
//  Nano1
//
//  Created by Randy Julian on 19/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var phoneNumber: String = "+62"
    @State private var selection: Bool = false
    @State private var showHomeScreen = false
    
    
    init() {
        if Category.loadCategories().isEmpty {
            let categories = [
                Category(name: "Apparel"),
                Category(name: "Stationary"),
                Category(name: "Electronic"),
                Category(name: "Other")
            ]
            
            Category.saveCategories(categories)
            let products = [
                LostItem(name: "test", description: "test", location: "test", date: Date(), category: categories[0]),
                LostItem(name: "test2", description: "test", location: "test", date: Date(), category: categories[0]),
                LostItem(name: "test3", description: "test", location: "test", date: Date(), category: categories[0])
            ]
            LostItem.saveItems(products)
        }
    }
    
    var body: some View {
//        VStack{
//            if showHomeScreen == false {
//                loginView()
//            } else {
//                homePage()
//            }
//        }
        ZStack{
            loginView()
            homePage()
        }
    }
    
    @State var currentIndex: Int = 0
    func loginView() -> some View {
        GeometryReader {
            let size = $0.size
            VStack{
                Group {
                    Text("iFound")
                        .padding(.top, 50)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 150)
                    Text("Lost your mind? We can't help with that, but if you've lost your stuff, we've got you covered!")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .italic()
                        .multilineTextAlignment(.center)
                }
                Spacer()
                VStack {
                    HStack{
                        Text("Enter your Phone Number")
                            .font(.subheadline)
                            .padding(.top, 30)
                        Spacer()
                        
                        ForEach(modelData.owners) { owner in
                            Text(owner.phoneNumber)
                        }
                    }
                    TextField("Phone Number", text: $phoneNumber)
                        .padding(.all)
                        .frame(height: 45)
                        .background(Color(hex: "EFEFF0"))
                        .cornerRadius(7)
                        .foregroundColor(.black)
                    
                    Button {
                        var isExist = false
                        for owner in modelData.owners {
                            if owner.phoneNumber == $phoneNumber.wrappedValue {
                                isExist = true
                                break
                            }
                        }
                        if isExist == false {
                            let loggedInOwner = Owner(phoneNumber: $phoneNumber.wrappedValue)
                            modelData.owners.append(loggedInOwner)
                            Owner.saveOwners(modelData.owners)
                        }
//                                    self.selection = true
                        showHomeScreen.toggle()
                        currentIndex+=1
                    } label: {
                      Text("Continue")
                            .frame(width: 330, height: 30)
                    }
                    .padding(.top, 15)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                }
                .padding(.bottom, 100)
            }
            .background(content: {
                Image("wave")
                    .resizable()
                    .frame(width: 1179.0, height: 400.0)
                    .matchedGeometryEffect(id: "wave", in: bg)
            })
            .padding(.horizontal, 20)
            .offset(x: -size.width * CGFloat(currentIndex - 0))
            .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 0 ? 0.2 : 0).delay(currentIndex == 0 ? 0.2 : 0), value: showHomeScreen)
            .background(Color(.white))
        }
    }
    
    @Namespace var bg
    @State var search = ""
    @State var selectedCategoryID = ""
    func homePage()-> some View {
        GeometryReader {
            let size = $0.size
            NavigationView {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(modelData.categories) { category in
                                Button(action: {
                                    if selectedCategoryID != category.id.uuidString {
                                        selectedCategoryID = category.id.uuidString
                                    } else {
                                        selectedCategoryID = ""
                                    }
                                }) {
                                    Text(category.name)
                                        .font(.system(size: 18))
                                }
                                .buttonStyle(.bordered)
                                .tint(category.id.uuidString == selectedCategoryID  ? .gray : .blue)
                                .cornerRadius(5)
                            }
                        }
                    }
                    .padding(.leading, 16)
                    
                    ItemListView(search: $search, selectedCategoryID: $selectedCategoryID)
                    .searchable(text: $search)
                    .pickerStyle(.segmented)
                    .padding(.top, -4)
                    
                    NavigationLink(destination: ReportFormView()) {
                        Text("Submit a Report")
                            .frame(width: 330, height: 10)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .background(content: {
                    Image("wave")
                        .resizable()
                        .matchedGeometryEffect(id: "wave", in: bg)
                        .frame(width: 1179.0, height: 400.0)
                        .offset(x:-300, y:300)
                    
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Text("iFound")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.black)
                            Image("logo")
                                .resizable()
                                .frame(width: 30, height: 45)
                        }
                        .frame(height: 200)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Home").bold().font(.largeTitle)
                        }
                        .frame(height: 200)
                    }
                }
                
            }
            .offset(x: -size.width * CGFloat(currentIndex - 1))
            .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 1 ? 0 : 0.2).delay(currentIndex == 1 ? 0.1 : 0), value: showHomeScreen)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
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
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
