//
//  AddView.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

struct AddView: View {
    
    init() {
        name = ""
        vol = ""
        image = nil
    }
    
    @State private var name = ""
    @State private var errorbool = false
    @State private var vol : String = "" //in ml
    
    
    
    @State private var image: UIImage?
    @State var showPicker: Bool = false
    @State var showDialog: Bool = false
    @State var showCamera: Bool = false
    @State var selectedItem: PhotosPickerItem? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var drinkdb : DrinkDB
    
    @State var add : Bool = true
    
    var body: some View {
        if add == true {
            main
        } else {
            DrinkView()
        }
    }
    
    var main: some View {
        NavigationView{
            ZStack{
                VStack {
                    if(image != nil) {
                        Image(uiImage: image!)
                            .resizable()
                            .frame(width: 330, height: 330)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(20)
                            .onTapGesture {
                                showDialog = true
                            }
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 330,height: 330)
                            .foregroundColor(Color.black.opacity(0.2))
                            .onTapGesture{
                                showDialog = true
                            }
                            .overlay(Text("Upload a picture of your drink"))
                    }
                    
                    
                    TextField("Drink name", text: $name)
                        .frame(minWidth: 0,maxWidth: 300)
                        .font(.system(size:18))
                        .padding()
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1))
                    
                    TextField("Volume in ml", text: $vol)
                        .keyboardType(.numberPad)
                        .frame(minWidth: 0,maxWidth: 300)
                        .font(.system(size:18))
                        .padding()
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1))
                    Spacer()
                    Button {
                        add = false
                        
                        if image.self != nil {
                            if name != "" {
                                upload(name: name, vol: Int(vol) ?? 0)
                                drinkdb.fetchDrinksWSID(sID: MyLocalStorage().getValue(key: "currentSession"))
                                print("added!")
                            } else {
                                errorbool = true
                            }
                        } else {
                            errorbool = true
                        }
                    } label: {
                        Text("Done")
                            .frame(width: 300)
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                            .alert(isPresented: $errorbool) {
                                Alert(title: Text("Your input is invalid"),message: nil, dismissButton: .cancel())
                            }
                    }
                    .padding()
                }
                .padding(.horizontal, 20)
                .confirmationDialog("Upload a photo", isPresented: $showDialog) {
                            Button {
                                showCamera.toggle()
                            } label: {
                                Label("Take a picture", systemImage: "camera")
                            }
                            Button {
                                showPicker.toggle()
                            } label: {
                                Label("Choose a picture", systemImage: "photo.artframe")
                            }
                        }
                .sheet(isPresented: $showCamera, content: {
                    ImagePicker(sourceType: .camera, selectedImage: $image)
                })
                .sheet(isPresented: $showPicker, content: {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                })
            }
        }
        
    }
    
    public func clear() {
        image = nil
    }
    
    func upload(name: String, vol: Int) {
        
        let name : String = name
        let vol : Int = vol
        
        var alldrinks : [String] = []
        
        //Image isnt nil
        guard image != nil else {
            return
        }
        
        //create reference
        let storageRef = Storage.storage().reference()
        
        let imageData = image!.jpegData(compressionQuality: 0.1)
        
        guard imageData != nil else {
            return
        }
        //specify file name
        
        let path = "DrinksImages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                let id = db.collection("drink").document().documentID
                db.collection("drink").document().setData([
                    "name": name,
                    "volume": vol,
                    "id": id,
                    "pic": path
                ])
                
                let query = db.collection("drinksSession").whereField("id", isEqualTo: drinkdb.id /*"yqpUTddjiglEiREZ7IMl"*/)
                    query.getDocuments { snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    if let snapshot = snapshot {
                        alldrinks = snapshot.documents.map { data in
                            let drinks : [String] = data["alldrinks"] as? [String] ?? [""]
                            for drink in drinks {
                                return drink
                            }
                            return ""
                        }
                    }
                }
                alldrinks.append(id)
                // add new drink to drinksSession
                db.collection("drinksSession").document(MyLocalStorage().getValue(key: "currentSession")).updateData([
                    "alldrinks": alldrinks
                ])
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
