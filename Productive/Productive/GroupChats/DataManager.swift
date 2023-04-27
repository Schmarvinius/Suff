//
//  GroupDM.swift
//  Productive
//
//  Created by Moser, Yannis on 23.04.23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth


 
class DataManager: ObservableObject {
    
    @Published var friends: [User] = []
    @Published var chats: [User] = []
    @Published var groups: [Group] = []
    @Published var attribut: String = ""
    @Published var field : [String] = [""]
    init() {
        fetchFriends()
        fetchGroup()
        fetchChats()
    }
    func getField(collection: String, dbfield : String, query : String, field : String){
        let db = Firestore.firestore()
        let ref = db.collection(collection)
        ref.whereField(dbfield, isEqualTo: query)
            .getDocuments(){snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot {
                    for document in snapshot.documents{
                        let data = document.data()
                        self.field = data[field] as? [String] ?? [""]
                    }
                }
            }
    }
    
    func getAttribut(collection: String, dbfield : String, query : String, field : String){
        let db = Firestore.firestore()
        let ref = db.collection(collection)
        ref.whereField(dbfield, isEqualTo: query)
            .getDocuments(){snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot {
                    for document in snapshot.documents{
                        let data = document.data()
                        
                        self.attribut = data[field] as? String ?? ""
                    }
                }
            }
    }

    func fetchGroup(){
        let user = Auth.auth().currentUser
        if let user = user {
            let email : String = user.email ?? "Fehler"
            groups.removeAll()
            let db = Firestore.firestore()
            let ref = db.collection("user")
            
            // Create a query against the collection.
            let query = ref.whereField("id", isEqualTo: email)
            query.getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshot = snapshot{
                    let data = snapshot.documents[0].data()
                    let groupIDs : [String] = data["groups"] as? [String] ?? [""]
                    
                    for groupID in groupIDs {
                        let query = db.collection("group").whereField("id", isEqualTo: groupID)
                        query.getDocuments { snapshot, error in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                return
                            }
                            if let snapshot = snapshot {
                                for document in snapshot.documents{
                                    let data = document.data()
                                    let id = data["id"] as? String ?? ""
                                    let name = data["name"] as? String ?? ""
                                    let userIDs:[String] = data["users"] as? [String] ?? [""]
                                    let group = Group(id: id, name: name, userIDs: userIDs)
                                    self.groups.append(group)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func fetchFriends(){
        let user = Auth.auth().currentUser
        if let user = user {
            let email : String = user.email ?? "Fehler"
            friends.removeAll()
            let db = Firestore.firestore()
            let ref = db.collection("user")
            ref.whereField("id", isEqualTo: email)
                .getDocuments(){snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    if let snapshot = snapshot {
                        for document in snapshot.documents{
                            let data = document.data()
                            
                            let friends: [String] = data["friends"] as? [String] ?? [""]
                            
                        
                            for friend in friends{
                                ref.whereField("id", isEqualTo: friend).getDocuments(){snapshot, error in
                                    guard error == nil else {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                
                                if let snapshot = snapshot {
                                    for document in snapshot.documents{
                                        let data = document.data()
                                        let id = data["id"] as? String ?? ""
                                        let firstname = data["firstname"] as? String ?? ""
                                        let lastname = data["lastname"] as? String ?? ""
                                        let groups:[String] = data["groups"] as? [String] ?? [""]
                                        
                                        
                                        let user = User(id: id, firstname: firstname, lastname: lastname, groupIDs: groups)
                                        self.friends.append(user)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fetchChats(){
        let user = Auth.auth().currentUser
        if let user = user {
            let email : String = user.email ?? "Fehler"
            chats.removeAll()
            
            let db = Firestore.firestore()
            let ref = db.collection("user")
            ref.whereField("id", isEqualTo: email)
                .getDocuments(){snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    
                    if let snapshot = snapshot {
                        for document in snapshot.documents{
                            let data = document.data()
                            
                            let chats: [String] = data["chats"] as? [String] ?? [""]
                            
                        
                            for chat in chats{
                                ref.whereField("id", isEqualTo: chat).getDocuments(){snapshot, error in
                                    guard error == nil else {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                
                                if let snapshot = snapshot {
                                    for document in snapshot.documents{
                                        let data = document.data()
                                        let id = data["id"] as? String ?? ""
                                        let firstname = data["firstname"] as? String ?? ""
                                        let lastname = data["lastname"] as? String ?? ""
                                        let groups:[String] = data["groups"] as? [String] ?? [""]
                                        
                                        
                                        let user = User(id: id, firstname: firstname, lastname: lastname, groupIDs: groups)
                                        self.chats.append(user)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
