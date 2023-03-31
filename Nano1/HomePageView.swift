//
//  HomePageView.swift
//  Nano1
//
//  Created by Randy Julian on 20/03/23.
//

//import SwiftUI
//
//struct HomePageView: View {
//    let logoImage: Namespace.ID
//    let logo: Namespace.ID
//    
//    @State var search = ""
//    @EnvironmentObject var modelData: ModelData
//    
//    @State var selectedCategoryID = ""
//    var body: some View {
//        NavigationView {
//            VStack {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack{
//                        ForEach(modelData.categories) { category in
//                            Button(action: {
//                                if selectedCategoryID != category.id.uuidString {
//                                    selectedCategoryID = category.id.uuidString
//                                } else {
//                                    selectedCategoryID = ""
//                                }
//                            }) {
//                                Text(category.name)
//                                    .font(.system(size: 18))
//                            }
//                            .buttonStyle(.bordered)
//                            .tint(category.id.uuidString == selectedCategoryID  ? .gray : .blue)
//                            .cornerRadius(5)
//                        }
//                    }
//                }
//                .padding(.leading, 16)
//                
//                ItemListView(search: $search, selectedCategoryID: $selectedCategoryID)
//                .searchable(text: $search)
//                .pickerStyle(.segmented)
//                .padding(.top, -4)
//                
//                NavigationLink(destination: ReportFormView()) {
//                    Text("Submit a Report")
//                        .frame(width: 330, height: 10)
//                        .padding()
//                        .background(.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    HStack {
//                        Text("iFound")
//                            .fontWeight(.bold)
//                            .font(.title)
//                            .foregroundColor(.black)
//                        Image("logo")
//                            .resizable()
//                            .frame(width: 30, height: 45)
//                            .matchedGeometryEffect(id: logoImage, in: logo)
//                    }
//                    .frame(height: 200)
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    VStack {
//                        Text("Home").bold().font(.largeTitle)
//                    }
//                    .frame(height: 200)
//                }
//            }
//        }
//        .background(Color(.white))
//    }
//}
//
//struct HomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(ModelData())
//    }
//}
