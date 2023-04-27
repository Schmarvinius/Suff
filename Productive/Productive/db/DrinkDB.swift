//
//  DrinkDB.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class DrinkDB: ObservableObject{
    
    @Published var drinks: [Drink] = []
    //@Published var sessions: [Sessions] = []
    
    
    init() {
        fetchDrinks()
        //fetchSessions()
    }
    
    //get user
    //get sessionID
    //load all dirnks from session
    
    /*func fetchDrinks() {
        drinks.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("drink")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let volume = data["volume"] as? Int ?? 0
                    let pic = data["pic"] as? String ?? ""
                        
                    self.drinks.append(Drink(id: id, name: name, pic: pic, volume: volume))
            }
            }
        }
    }*/
    
    func fetchDrinks() {
        drinks.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("user")
        let user = Auth.auth().currentUser
        
        if let user = user {
            let email : String = user.email ?? "Fehler"
            let query = ref.whereField("id", isEqualTo: email)
            query.getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshot = snapshot {
                    let data = snapshot.documents[0].data()
                    let sessionIDs : [String] = data["sessions"] as? [String] ?? [""]
                    
                    for sessionID in sessionIDs {
                        let query = db.collection("drinksSession").whereField("id", isEqualTo: sessionID)
                        query.getDocuments { snapshot,error in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                return
                            }
                            if let snapshot = snapshot {
                                let data = snapshot.document[0].data()
                                let ids : [String]  = data["alldrinks"] as? [String] ?? [""]
                                
                                for id in ids {
                                    let query = db.collection("drink").whereField("id", isEqualTo: id)
                                    query.getDocuments { snapshot,error in
                                        guard error == nil else {
                                            print(error!.localizedDescription)
                                            return
                                        }
                                        if let snapshot = snapshot {
                                            //let id = db.collection("dirnk").document().documentID
                                            
                                            let data = snapshot.document.data()
                                            
                                            let id = data["id"] as? String ?? ""
                                            let name = data["name"] as? String ?? ""
                                            let volume = data["volume"] as? Int ?? 0
                                            let pic = data["pic"] as? String ?? ""
                                        }
                                    }
                                }
                            //get all drinks
                            }
                        }
                    }
                }
            }
        }
    }
}
    
    

