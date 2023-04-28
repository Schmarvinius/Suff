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
    
    init() {
        
    }
    
    //Get all personal drinks form group

    @Published var drinks: [Drink] = []
    func fetchDrinksWSID(sID: String) {
        drinks.removeAll()
        let db = Firestore.firestore()
        let query = db.collection("drinksSession").whereField("id", isEqualTo: sID/*sessionID MyLocalStorage().getValue(key: "currentSession")*/)
            query.getDocuments { snapshot,error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        for document in snapshot.documents {
                            let data = document.data()
                            let ids : [String]  = data["alldrinks"] as? [String] ?? [""]
                            for id in ids {
                                let query = db.collection("drink").whereField("id", isEqualTo: id)
                                query.getDocuments { snapshot,error in
                                    guard error == nil else {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                    if let snapshot = snapshot {
                                        //let id = db.collection("drnk").document().documentID
                                            let test = snapshot.documents.map { data in
                                                let id = data["id"] as? String ?? ""
                                                let name = data["name"] as? String ?? ""
                                                let volume = data["volume"] as? Int ?? 0
                                                let pic = data["pic"] as? String ?? ""
                                                
                                                let newdrink = Drink(id: id, name: name, pic: pic, volume: volume)
                                                self.drinks.append(newdrink)
                                                return newdrink

                                            }
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
    
    @Published var id : String = ""
    func getSession(gid: String){
        let db = Firestore.firestore()
        let ref = db.collection("drinksSession")
        let query = ref.whereField("gid", isEqualTo: gid)
        query.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                let data = snapshot.documents[0].data()
                self.id = data["id"] as? String ?? ""
            }
        }
    }
}
    
    

