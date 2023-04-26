//
//  AddChatView.swift
//  Productive
//
//  Created by Moser, Yannis on 25.04.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddChatView: View {
    @EnvironmentObject var dataManager: DataManager
    var body: some View {
        NavigationView(){
            VStack{
                List(dataManager.friends, id: \.id){friend in
                    Button(action:{
                      
                            addChat(user: friend)
                        
                    }, label:{
                        HStack{
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color.black)
                            Text(friend.firstname)
                            Text(friend.lastname)
                            Spacer()
                            NavigationLink("",destination: GroupView())
                                .environmentObject(dataManager)
                            
                        }
                    })
                }
            }
                .navigationTitle("Add Chat")
            
        }
       
    }
    private func addChat(user: User){
        var addchats: [String] = []
        var notused = true
        for chat in dataManager.chats{
            addchats.append(chat.id)
            if(chat.id == user.id){
                notused = false
            }
        }
        if(notused){
            addchats.append(user.id)
        }
        
        let account = Auth.auth().currentUser
        let id = account!.uid
        print(id)
        let ref = Firestore.firestore().collection("user").document(id)
        ref.updateData([
            "chats": addchats
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
            dataManager.fetchChats()            
    }
}

struct AddChatView_Previews: PreviewProvider {
    static var previews: some View {
        AddChatView()
            .environmentObject(DataManager())
    }
}
