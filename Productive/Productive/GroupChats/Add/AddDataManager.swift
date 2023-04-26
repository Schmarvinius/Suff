//
//  AddDataManager.swift
//  Productive
//
//  Created by Moser, Yannis on 26.04.23.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AddDataManager: ObservableObject {
    @EnvironmentObject var addDataManager: AddDataManager
    @EnvironmentObject var dataManager: DataManager
    
    func addChat(user: User, dataManager : DataManager){
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
    
    func addGroupWithID(groupID : String , dataManager : DataManager){
        let db = Firestore.firestore()
        let account = Auth.auth().currentUser
        let uid = account!.uid
        
        // ADD User to users List in Group
        var ref = db.collection("group")
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
        //Getting the Group-List of User
        var userGroups: [String] = []
        ref = db.collection("user")
        ref.whereField("id", isEqualTo: account!.email ?? "").getDocuments(){snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                let  document = snapshot.documents[0]
                    let data = document.data()
                    userGroups = data["groups"] as? [String] ?? [""]
                userGroups.append(groupID)
                
                ref.document(uid).updateData([
                    "groups": userGroups
                ]){ err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        dataManager.fetchGroup()
                    }
                }
            }
        }
    }
}

