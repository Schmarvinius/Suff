//
//  DrinkDB.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import Foundation
import Firebase
import FirebaseFirestore

class DrinkDB: ObservableObject{
    
    @Published var drinks: [Drink] = []
    
    init() {
        fetchDrinks()
    }
    
    func fetchDrinks() {
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
    }
}
