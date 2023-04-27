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

    var body: some View {
        NavigationView{
            VStack{
            VStack(spacing: 16){
                Text("Join Group")
                    .foregroundColor(.black)
                    .font(.system(size:30,weight: .bold, design: .rounded))
                    .offset(y:10)
                TextField("Group-ID", text: $groupID)
                    .foregroundColor(Color.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: groupID.isEmpty) {
                        Text("Group-ID")
                            .foregroundColor(.black)
                            .bold()
                    }
                Rectangle()
                    .frame(width: width,height: 1)
                    
                    
                Button {
                    addDataManager.addUserToGroup(groupID: groupID, dataManager: dataManager)
                    addDataManager.addGroupWithID(groupID: groupID, dataManager: dataManager)
                } label: {
                    Text("Join")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.gray, .gray], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                    
                }
                

            }
                
            .frame(width: width)
                VStack(spacing: 16){
                    Text("Create Group")
                        .foregroundColor(.black)
                        .font(.system(size:30,weight: .bold, design: .rounded))
                        .offset(y:10)
                    
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

                    TextField("Groupname", text: $groupName)
                        .foregroundColor(Color.black)
                        .textFieldStyle(.plain)
                        .placeholder(when: groupName.isEmpty) {
                            Text("Groupname")
                                .foregroundColor(.black)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: width,height: 1)
                    
                    
                    TextField("Description", text: $description)
                        .foregroundColor(Color.black)
                        .textFieldStyle(.plain)
                        .placeholder(when: description.isEmpty) {
                            Text("Description")
                                .foregroundColor(.black)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: width,height: 1)
                    
                    Button {
                        upload(name: groupName, description: description)
                    } label: {
                        Text("Create")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.gray, .gray], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                }
                .sheet(isPresented: $shouldShowImagePicker, content: {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image )
                })
        
                Spacer()
            }
            .frame(width: width)
            
        }
        .background(.gray)
    }
    
    func upload(name: String, description: String) {
        let name : String = self.groupName
        let description : String = self.description
        let users : [String] = [Auth.auth().currentUser?.email ?? ""]
        var ids : [String] = []
        
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
        
        let path = "GroupsImages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                let id = db.collection("group").document().documentID
                let sid = db.collection("drinksSession").document().documentID
                db.collection("group").document(id).setData([
                    "name": name,
                    "description": description,
                    "id": id,
                    "pic": path,
                    "users": users,
                    "sessionID": sid
                ])
                addDataManager.addGroupWithID(groupID: id, dataManager: dataManager)
                
                db.collection("drinksSession").document(sid).setData([
                    "id": sid,
                    "alldrinks": []
                ])
                
                let query = db.collection("user").whereField("id", isEqualTo: Auth.auth().currentUser?.email ?? "")
                    query.getDocuments { snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    if let snapshot = snapshot {
                        let data = snapshot.documents[0].data()
                        let sids : [String] = data["sessions"] as? [String] ?? [""]
                        
                        for sid in sids {
                            ids.append(sid)
                        }
                        ids.append(sid)
                        db.collection("user").document(Auth.auth().currentUser?.uid ?? "").updateData([
                            "sessions": ids
                        ])
                    }
                    
                }
                
                
                
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
