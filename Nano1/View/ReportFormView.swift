//
//  ReportFormView.swift
//  Nano1
//
//  Created by Randy Julian on 22/03/23.
//

import SwiftUI
import PhotosUI

import ImageIO


struct ReportFormView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var modelData: ModelData
    @State private var itemName = ""
    @State private var itemLocation = ""
    @State private var itemDesc = ""
    @State private var selectedDate: Date = .now
    @State private var selectedCategory: Category?
    
    @State var selectedPhoto: [PhotosPickerItem] = []
    @State var data: Data?
    @Binding var loggedInUser: Owner?
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                VStack {
                    Text("Report Form")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.bottom, -8)
                    Group{
                        HStack{
                            Text("Item Name")
                                .padding()
                                .padding(.bottom, -10)
                            Spacer()
                        }
                        TextField("Enter Item Name", text: $itemName)
                            .padding(.all)
                            .frame(width: 360, height: 35)
                            .background(Color(hex: "EFEFF0"))
                            .cornerRadius(7)
                            .foregroundColor(.black)
                    }
                    
                    Group{
                        HStack{
                            Text("Location")
                                .padding()
                                .padding(.bottom, -10)
                            Spacer()
                        }
                        TextField("Enter Item's Found Location", text: $itemLocation)
                            .padding(.all)
                            .frame(width: 360, height: 35)
                            .background(Color(hex: "EFEFF0"))
                            .cornerRadius(7)
                            .foregroundColor(.black)
                        
                    }
                    
                    
                    VStack{
                        DatePicker("Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .padding()
                        
                    }
                    
                    Group{
                        HStack{
                            Text("Category")
                                .padding()
                                .padding(.top, -10)
                                .padding(.bottom, -10)
                            Spacer()
                            
                            VStack {
                                Picker("Select category", selection: $selectedCategory) {
                                    ForEach(modelData.categories) { category in
                                        Text(category.name).tag(category as Category?)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                        }
                    }
                    
                    HStack{
                        Text("Description")
                            .padding()
                            .padding(.bottom, -10)
                        Spacer()
                    }
                    TextField("Enter Item Description", text: $itemDesc, axis: .vertical)
                        .lineLimit(3)
                        .padding(.all)
                        .frame(width: 360, height: 100)
                        .background(Color(hex: "EFEFF0"))
                        .cornerRadius(7)
                        .foregroundColor(.black)
                    
                    Group{
                        HStack{
                            Text("Attachment")
                            Spacer()
                            
                            
                            PhotosPicker(
                                selection: $selectedPhoto,
                                maxSelectionCount: 1,
                                matching: .images
                            ) {
                                Text("Pick Photo")
                            }
                            .onChange(of: selectedPhoto) { newValue in
                                guard let item = selectedPhoto.first else {
                                    return
                                }
                                
                                item.loadTransferable(type: Data.self) { result in
                                    switch result {
                                    case .success(let data):
                                        if let data = data {
                                            self.data = data
                                        } else {
                                            print("Data is nil")
                                        }
                                    case .failure(let failure):
                                        print(failure)
                                    }
                                }
                            }

                        }
                        .padding()
                        .padding(.bottom, -10)

                        if let data = data, let uiimage = UIImage(data: data){
                            Image(uiImage: uiimage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 361, height: 361)

                        }
                            
                        
                    }

                    Button {
                        let imageName = UUID().uuidString + ".png"
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
                        if let data = data, var uiimage = UIImage(data: data){
                            uiimage = rotateImage(image: uiimage) ?? UIImage(data: data)!
                            do {
                                try uiimage.pngData()?.write(to: path)
                                
                                print("Image saved")
                            }
                            catch {
                                print("some error" + error.localizedDescription)
                            }

                        }
                        let item = LostItem(name: itemName, description: itemDesc, location: itemLocation, date: selectedDate, category: (selectedCategory ?? modelData.categories.first)!, owner: loggedInUser, imageName: path)

                        modelData.lostItems.append(item)
                        LostItem.saveItems(modelData.lostItems)
                        self.presentation.wrappedValue.dismiss()
                    } label: {
                        Text("Submit")
                            .frame(width: 330, height: 27)
                        
                    }
                    .padding(.bottom, 10)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
                    
//                    ForEach(modelData.lostItems) { item in
//                        Text(item.name)
//                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
    func rotateImage(image: UIImage) -> UIImage? {
        if image.imageOrientation == UIImage.Orientation.up {
            return image /// already upright, no need for changes
        }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy
    }
    

}

struct ReportFormView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
