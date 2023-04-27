//
//  AddGroupView.swift
//  Productive
//
//  Created by Moser, Yannis on 25.04.23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

struct AddGroupView: View {
    @State private var groupID = "9qDpNvwG8VO1zQyA6NgM"
    @State private var groupName = ""
    @State private var description = ""
    @State private var shouldShowImagePicker = false
    @State private var width : CGFloat? = 350
    @State private var image: UIImage?
    @EnvironmentObject var addDataManager: AddDataManager
    @EnvironmentObject var dataManager: DataManager

    @State private var willJoin = true
    
    
    var body: some View {
        VStack {
            Picker(selection: $willJoin, label: Text("Picker here")){
                Text("Join")
                    .tag(true)
                Text("Create")
                    .tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if willJoin {
                contentJoin
            }
            else {
                contentCreate
            }
        }
        .navigationTitle(willJoin ? "Join" : "Create")
        .navigationBarTitleDisplayMode(.inline)
    }
    var contentJoin: some View {
        Form {
            Section (header: Text("Group ID")){
                TextField("id", text: $groupID)
            }
            Section {
                Button(action: {}) {
                    HStack {
                        Spacer()
                        Text("Join")
                        Spacer()
                    }
                }
            }
        }
        .scrollDisabled(true)
        .cornerRadius(20)
        .padding(.all)
    }
    var contentCreate: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    shouldShowImagePicker.toggle()
                } label: {
                    if(image != nil){
                        Image(uiImage: image!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(20)
                            .onTapGesture {
                                shouldShowImagePicker.toggle()
                            }
                    }else{
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .foregroundColor(Color.black)
                    }
                    
                    
                   
                }
                Spacer()
            }
            Form {
                Section(header: Text("Group details")) {
                    TextField("Name", text: $groupName)
                    TextField("Description", text: $description)
                }
                Section {
                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("Create Group")
                            Spacer()
                        }
                    }
                }
            }
            .sheet(isPresented: $shouldShowImagePicker, content: {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image )
            })
            .scrollDisabled(true)
            .cornerRadius(20)
            .padding(.all)
        }
    }
    
    func upload(name: String, description: String) {
        let name : String = self.groupName
        let description : String = self.description
        let users : [String] = [Auth.auth().currentUser?.email ?? ""]
        
        //Image isnt nil
        guard image != nil else {
            return
        }
        
        //create reference
        let storageRef = Storage.storage().reference()
        
        let imageData = image!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        //specify file name
        
        let path = "GroupsImages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                let id = db.collection("group").document().documentID
                db.collection("group").document(id).setData([
                    "name": name,
                    "description": description,
                    "id": id,
                    "pic": path,
                    "users": users
                ])
                addDataManager.addGroupWithID(groupID: id, dataManager: dataManager)
            }
        }
        
    }
}



extension View{
    func placeholder <Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment){
                placeholder().opacity(shouldShow ? 1 : 0)
                            self
            }
    }
}




struct AddGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddGroupView()
    }
}
