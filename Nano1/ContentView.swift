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
    @State private var password: String = ""
    @State private var selection: Bool = false
    @State private var showHomeScreen = false
    @State var loggedInUser: Owner?
    @State var errorMessage = ""
    init() {
//        Category.saveCategories([])
//        Owner.saveOwners([])
//        LostItem.saveItems([])
        if Category.loadCategories().isEmpty {
            Category.saveCategories([])
            Owner.saveOwners([])
            LostItem.saveItems([])
            let owners = [
                Owner(phoneNumber: "081888888888", password: "000"),
                Owner(phoneNumber: "081333333333", password: "000"),
                Owner(phoneNumber: "081222222222", password: "000")
            ]
            Owner.saveOwners(owners)
            let categories = [
                Category(name: "Apparel"),
                Category(name: "Stationary"),
                Category(name: "Electronic"),
                Category(name: "Other")
            ]
            
            Category.saveCategories(categories)
            let products = [
                LostItem(name: "Tas Adidas Camo Hitam Kecil", description: "Di dalemnya ada nota struk pembayaran dan hand sanitizer", location: "Pantry dekat mesin kopi", date: Date(), category: categories[3], owner: owners[0], localImage: "tas"),
                LostItem(name: "Buku Notebook Biru Kecil", description: "Baru keisi di 3 halaman awal", location: "Meja outdoor dekat para tanaman", date: Date(), category: categories[1], owner: owners[1], localImage: "buku"),
                LostItem(name: "Charger iPhone", description: "Kepala charger merk anker warna putih", location: "Lab 1 dekat meja operator", date: Date(), category: categories[2], owner: owners[2], localImage: "charger"),
                LostItem(name: "Sleeve Laptop Besar", description: "Merk evoque, warna abu-abu, ada bolpen didalemnya", location: "Lab 2 dekat sofa tengah", date: Date(), category: categories[2], owner: owners[2], localImage: "sleeve"),
                LostItem(name: "Jaket Adidas Biru", description: "Bahan parasut, harusnya yang punya cowo, ada masker di kantong", location: "Sofa kuning lab 1 di pojokan", date: Date(), category: categories[0], owner: owners[1], localImage: "jaket")
            ]
            LostItem.saveItems(products)
        }
    }
    @State private var skipSplashScreen = false
    var body: some View {
        ZStack{
            loginView()
            homePage()
            if skipSplashScreen == false {
                SplashScreen()
            }
        }
        .preferredColorScheme(.light)
    }
    
    @State var currentIndex: Int = 0
    func loginView() -> some View {
        GeometryReader {
            let size = $0.size
            VStack{
                Group {
//                    if showHomeScreen == false {
                        VStack{
                            Image("logoText")
                                .resizable()
                                .matchedGeometryEffect(id: "logoText", in: logo)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200)
                                .padding(.bottom, -20)
                                .padding(.top, 20)
                            
                            
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .matchedGeometryEffect(id: "logoImage", in: logo)
                                .frame(width: 100)
                        }
//                    }
                    Text("Lost your mind? We can't help with that, but if you've lost your stuff, we've got you covered!")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .italic()
                        .multilineTextAlignment(.center)
//                        .offset(y: showHomeScreen ? 260 : 160)
                }
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 0 ? 0.2 : 0).delay(currentIndex == 0 ? 0.2 : 0), value: showHomeScreen)
                Spacer()
                VStack {
                    
                    Group {
                        HStack{
                            Text("Enter your Phone Number")
                                .font(.subheadline)
                                .padding(.top, 30)
                                .foregroundColor(.black)
                            Spacer()
                            
                            if errorMessage != "" {
                                Text(errorMessage)
                                    .font(.subheadline)
                                    .padding(.top, 30)
                                    .foregroundColor(.red)
                            }
//                            ForEach(modelData.owners) { owner in
//                                Text(owner.phoneNumber)
//                            }
                        }
                        TextField("Phone Number", text: $phoneNumber)
                            .padding(.all)
                            .frame(height: 45)
                            .background(Color(hex: "EFEFF0"))
                            .cornerRadius(7)
                            .foregroundColor(.black)
                        
                        SecureField("Password", text: $password)
                            .padding(.all)
                            .frame(height: 45)
                            .background(Color(hex: "EFEFF0"))
                            .cornerRadius(7)
                            .foregroundColor(.black)
                    }
                    .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == 0 ? 0.2 : 0), value: showHomeScreen)
                    
                    Button {
                        var isExist = false
                        for owner in modelData.owners {
                            if owner.phoneNumber == phoneNumber {
                                if owner.password == password {
                                    print(password)
                                    loggedInUser = owner
                                    errorMessage = ""
                                    skipSplashScreen = true
                                    showHomeScreen.toggle()
                                    currentIndex = 1
                                } else {
                                    errorMessage = "wrong password"
                                }
                                isExist = true
                                break
                            }
                        }
                        if isExist == false {
                            if password.isEmpty {
                                errorMessage = "fill the password"
                            } else {
                                loggedInUser = Owner(phoneNumber: phoneNumber, password: password)
                                modelData.owners.append(loggedInUser!)
                                Owner.saveOwners(modelData.owners)
                                skipSplashScreen = true
                                showHomeScreen.toggle()
                                currentIndex = 1
                            }
                        }
//                        print(loggedInUser)
                    } label: {
                      Text("Continue")
                            .frame(width: 330, height: 30)
                    }
                    .matchedGeometryEffect(id: "button", in: button)
                    .zIndex(2)
                    .padding(.top, 15)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 0 ? 0 : 0.2).delay(currentIndex == 0 ? 0.2 : 0), value: showHomeScreen)
                }
                .padding(.bottom, 100)
            }
            .background(content: {
                Image("wave")
                    .resizable()
                    .frame(width: 1179.0, height: 400.0)
                    .matchedGeometryEffect(id: "wave", in: bg)
                    .zIndex(-1)
            })
            .padding(.horizontal, 20)
            .offset(x: -size.width * CGFloat(currentIndex - 0))
        }
    }
    
    @Namespace var bg
    @Namespace var button
    @Namespace var logo
    @State var selectedCategoryID = ""
    @State var searcQuery = ""
    @State var offset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    
    @State var titleOffset: CGFloat = 0
    
    @State var titleBarHeight: CGFloat = 0
    
    func homePage()-> some View {
        GeometryReader {
            let size = $0.size
            NavigationView {
                ZStack(alignment: .top) {
                    VStack{
                        if searcQuery == ""{
                                HStack{
                                    Button(action: {
                                        showHomeScreen.toggle()
                                        currentIndex = 0
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .font(.title2)
                                            .foregroundColor(.black)
                                    }
                                    
                                    Spacer()
                                    
                                    HStack {
                                        if showHomeScreen == true {
                                            
                                            Image("logoText")
                                                .resizable()
                                                .matchedGeometryEffect(id: "logoText", in: logo)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 40)
                                                .padding(.trailing, -18)
                                            Image("logo")
                                                .resizable()
                                                .matchedGeometryEffect(id: "logoImage", in: logo)
                                                .scaledToFit()
                                                .frame(height: 30)
                                        }
                                    }
                                }
                                .padding()
                                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 1 ? 0 : 0.2).delay(currentIndex == 1 ? 0.1 : 0), value: showHomeScreen)
                            
                                HStack{
                                    Text("Home")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .font(.largeTitle)
                                    .overlay(
                                        GeometryReader{reader -> Color in
                                            let width = reader.frame(in: .global).maxX
                                            DispatchQueue.main.async {
                                                if titleOffset == 0 {
                                                    titleOffset = width
                                                }
                                            }
                                            return Color.clear
                                        }
                                            .frame(width: 0, height: 0)
                                    )
                                    .offset(getOffset())
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.vertical, -10)
                                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 1 ? 0 : 0.2).delay(currentIndex == 1 ? 0.1 : 0), value: showHomeScreen)
                        } else {
                            HStack {
                                if showHomeScreen == true {
                                    
                                    Image("logoText")
                                        .resizable()
                                        .matchedGeometryEffect(id: "logoText", in: logo)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 40)
                                        .padding(.trailing, -18)
                                    
                                    Image("logo")
                                        .resizable()
                                        .matchedGeometryEffect(id: "logoImage", in: logo)
                                        .scaledToFit()
                                        .frame(height: 30)
                                }
                            }
                        }
                        
                        VStack{
                            //Search Bar
                            HStack(spacing: 15) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                TextField("Search", text: $searcQuery)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(8)
                            .padding()
                            
                            if searcQuery == "" {
                                categoryView
                                    .padding(.top, -10)
                            }
                        }
                        .offset(y: offset > 0 && searcQuery == "" ? (offset <= 60 ? -offset : -60) : 0)
                        .offset(x: -size.width * CGFloat(currentIndex - 1))
                        .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 1 ? 0.2 : 0).delay(currentIndex == 1 ? 0.2 : 0), value: showHomeScreen)
                        
                        
                    }
                    .zIndex(1)
                    .padding(.bottom,searcQuery == "" ? getOffset().height : 0)
                    .background(
                        ZStack{
                            let color = Color.white
                            LinearGradient(gradient: .init(colors: [color,color,color,color, color.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                        }
                            .ignoresSafeArea()
                    )
                    .overlay(
                        GeometryReader{reader -> Color in
                            let height = reader.frame(in: .global).maxY
                            
                            DispatchQueue.main.async {
                                if titleBarHeight == 0 {
                                    titleBarHeight = height - (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                                    
                                }
                            }
                            return Color.clear
                        }
                    )
                    .animation(.easeInOut, value: searcQuery != "")
                    
                    ZStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            ItemListView(search: $searcQuery, selectedCategoryID: $selectedCategoryID, loggedInUser: $loggedInUser)
                            .padding(.top, 390)
                            .padding(.bottom, 50)
                            .padding(.top, searcQuery == "" ? titleBarHeight : 90)
                            .overlay(
                                GeometryReader{proxy -> Color in
                                    let minY = proxy.frame(in: .global).minY
                                    
                                    DispatchQueue.main.async {
                                        if selectedCategoryID == "" {
                                            if startOffset == 0 {
                                                startOffset = minY
                                            }
                                            offset = startOffset - minY
                                        }
                                    }
                                    
                                    print(minY)
                                    return Color.clear
                                }
                                .frame(width: 0, height: 0, alignment: .top)
                            )
                        }
                        .zIndex(1)
                        .padding(.top, searcQuery == "" ? -80 : -350)
                        .padding(.top, selectedCategoryID != "" && offset > 0 ? -60 : 0)
                        .offset(x: -size.width * CGFloat(currentIndex - 1))
                        .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == 1 ? 0.3 : 0).delay(currentIndex == 1 ? 0.3 : 0), value: showHomeScreen)
                        
                        VStack {
                            Spacer()
                            if showHomeScreen{
                                NavigationLink(destination: ReportFormView(loggedInUser: $loggedInUser)) {
                                    Text("Submit a Report")
                                        .frame(width: 330, height: 10)
                                        .padding()
                                        .background(.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    
                                }
                                .matchedGeometryEffect(id: "button", in: button)
                                .offset(x: -size.width * CGFloat(currentIndex - 1))
                                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == 1 ? 0.1 : 0), value: showHomeScreen)
                            }
                        }
                        .zIndex(2)
                    }
                    
                    
                }
               
                .background(content: {
                    ZStack{
//                        Color.white.zIndex(-2)
                        
                        Image("wave")
                            
                            .resizable()
                            .matchedGeometryEffect(id: "wave", in: bg)
                            .frame(width: 1179.0, height: 400.0)
                            .offset(x:-200, y:250)
                            .zIndex(-1)
                    }
                })
            }
            .offset(x: -size.width * CGFloat(currentIndex - 1))
            .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0).delay(currentIndex == 1 ? 0.1 : 0), value: showHomeScreen)
        }
    }
    
    var categoryView: some View {
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
    }
    
    
    func getOffset()->CGSize{
        var size: CGSize = .zero
        let screenWidth = UIScreen.main.bounds.width * 1.5
        //since width is slow moveing were multiplying with 1.5
        size.width = offset > 0 ? (offset * 1.5 <= (screenWidth - titleOffset) ? offset*1.5 : (screenWidth - titleOffset)) : 0
        size.height = offset > 0 ? (offset <= 50 ? -offset : -50) : 0
        
        return size
    }
    
    //little bit shrinking tutle when scrolling
    func getScale() -> CGFloat{
        if offset > 0{
            
            let screenWidth = UIScreen.main.bounds.width
            
            let progress = 1 - (getOffset().width / screenWidth)
            return progress >= 0.9 ? progress : 0.9
        }
        else {
            return 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
//        SplashScreen()
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

