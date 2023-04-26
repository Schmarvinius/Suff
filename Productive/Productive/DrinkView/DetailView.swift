//
//  DetailView.swift
//  Productive
//
//  Created by Lindner, Marvin on 21.04.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct DetailView: View {
    
    let name: String
    let volume: Int
    let pic: String
       
    init (name: String, volume: Int, pic: String) {
        self.name = name
        self.volume = volume
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
                     
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 330, height: 1)
                        .padding()
                    List{
                        HStack{
                            Text("Drink Name:")
                            Spacer()
                            Text(name)
                        }
                        HStack{
                            Text("Volume:")
                            Spacer()
                            Text(String(volume))
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            retrievephoto(pic: pic)
        }
    }
    
    func retrievephoto(pic: String) {
        let db = Firestore.firestore()
        
        db.collection("drink").getDocuments { snapshot, err in
            if err == nil && snapshot != nil {
                let storageRef = Storage.storage().reference()
                let fileRef = storageRef.child(pic)
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, err in
                    if err == nil && data != nil {
                        if let image = UIImage(data: data!) {
                            DispatchQueue.main.async {
                                retrievedImage = image
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Test", volume: 187, pic: "DrinksImages/EEAA9E55-AF65-4E2A-A384-C03D056AC62C.jpg")
            .environmentObject(drinkDB())
    }
}
