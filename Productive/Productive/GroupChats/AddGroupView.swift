//
//  AddGroupView.swift
//  Productive
//
//  Created by Moser, Yannis on 25.04.23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AddGroupView: View {
    @State private var groupID = "9qDpNvwG8VO1zQyA6NgM"
    @State private var groupName = ""
    @State private var description = ""
    @State private var shouldShowImagePicker = false
    @State private var width : CGFloat? = 350
    @State private var image: UIImage?

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
                    joingroup()
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
                    Text("Creat Group")
                        .foregroundColor(.black)
                        .font(.system(size:30,weight: .bold, design: .rounded))
                        .offset(y:10)
                    
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .foregroundColor(Color.black)
                    }

                    TextField("Groupname", text: $groupName)
                        .foregroundColor(Color.black)
                        .textFieldStyle(.plain)
                        .placeholder(when: groupID.isEmpty) {
                            Text("Groupname")
                                .foregroundColor(.black)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: width,height: 1)
                    
                    
                    TextField("Description", text: $description)
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
                        // Creat Group
                    } label: {
                        Text("Creat")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.gray, .gray], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                        
                    }
                    

                }
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                   // ImagePicker(image: $image)
                    }
                Spacer()
            }
            .frame(width: width)
            
        }
        .background(.gray)
    }
    
    func joingroup (){
        let db = Firestore.firestore()
        let account = Auth.auth().currentUser
        let uid = account?.uid
        
        // Controll if Group-ID exists
        let ref = db.collection("group")
        let group = ref.whereField("id", isEqualTo: groupID)
        group.getDocuments(){snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                let data = snapshot.documents[0].data()
                let gID = data["id"] as? String ?? ""
                var users : [String] = data["users"] as? [String] ?? [""]
                users.append(account?.email as? String ?? "")
                
                Firestore.firestore().collection("group").document(gID).updateData([
                    "users": users
                ]){ err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                
                
                
            }
        }
        //Clear Textfield
        groupID = ""
        
        //Get user groups
        let user = db.collection("user")
        
        
        
        
        
        
        
        
        
        
        
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
