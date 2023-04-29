//
//  DetailView.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct DetailView: View {
    
    @EnvironmentObject var drinkdb : DrinkDB
    
    @State private var name : String
    @State private var volume : String
    @State private var pic: String
       
    init (name: String, volume: Int, pic: String) {
        self.name = name
        self.volume = String(volume)
        self.pic = pic
        self.retrievedImage = nil
    }
    
    @State var retrievedImage : UIImage?
    
    
    
    var body: some View {
            NavigationView(){
                ZStack{
                    VStack{
                        if retrievedImage != nil {
                            Image(uiImage: retrievedImage!)
                                .resizable()
                                .frame(maxWidth: 330, maxHeight: 330)
                                .cornerRadius(20)
                                .aspectRatio(contentMode: .fill)
                        } else {
                            ZStack{
                                Rectangle()
                                    .frame(maxWidth: 330, maxHeight: 330)
                                    .cornerRadius(20)
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                    .scaleEffect(2)
                            }
                        }
                        Form{
                            Section (header: Text("Information")){
                                HStack{
                                    Text("Drink Name:")
                                    Spacer()
                                    TextField("", text: $name)
                                }
                                HStack{
                                    Text("Volume:")
                                    Spacer()
                                    TextField("", text: $volume)
                                        .keyboardType(.numberPad)
                                        .onChange(of: volume) { newValue in
                                            let filtered = newValue.filter{"0123456789".contains($0)}
                                            if filtered != newValue {
                                                volume = filtered
                                            }
                                        }
                                    Text("ml")
                                }
                            }
                        }
                        .cornerRadius(20)
                        .padding()
                        Spacer()
                        Text("Done")
                            .frame(width: 300)
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                }
                .navigationTitle("Details")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                //retrievephoto(pic: pic)
            }
        
    }
    
//    func retrievephoto(pic: String) {
//        let db = Firestore.firestore()
//
//        db.collection("drink").getDocuments { snapshot, err in
//            if err == nil && snapshot != nil {
//                let storageRef = Storage.storage().reference()
//                let fileRef = storageRef.child(pic)
//                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, err in
//                    if err == nil && data != nil {
//                        if let image = UIImage(data: data!) {
//                            DispatchQueue.main.async {
//                                retrievedImage = image
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Test", volume: 187, pic: "DrinksImages/EEAA9E55-AF65-4E2A-A384-C03D056AC62C.jpg")
            .environmentObject(DrinkDB())
    }
}
