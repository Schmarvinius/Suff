//
//  GroupDM.swift
//  Productive
//
//  Created by Moser, Yannis on 23.04.23.
//

import SwiftUI
import Firebase
import FirebaseCore
 
class DataManager: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        fetchUsers()
    }
    func fetchGroup(){
        
    }
    
    
    
    
    
    
    
    
    
    
    func fetchUsers(){
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("user")
        ref.getDocuments { snapshot, error in
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
                    self.users.append(user)
                }
            }
        }
            
    }
}

