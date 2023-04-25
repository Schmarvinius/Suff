//
//  DataManagerAchievements.swift
//  Productive
//
//  Created by Weber, Til on 25.04.23.
//

import SwiftUI
import Firebase
import FirebaseAuth

class DataManagerAchievements: ObservableObject {
    @Published var achievements: [Achievement] = []
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    
    
    init() {
        fetchAchievements()
        fetchUserData()
    }
    
    func fetchUserData(){
        let email = Auth.auth().currentUser?.email as? String ?? ""
        let db = Firestore.firestore()
        let ref = db.collection("user")
        ref.whereField("id", isEqualTo: email).getDocuments() { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                let data = snapshot.documents[0].data()
                self.firstname = data["firstname"] as? String ?? ""
                self.lastname = data["lastname"] as? String ?? ""
            }
        }
    }
    
    func fetchAchievements(){
        achievements.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("achievements")
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
                    let desc = data["desc"] as? String ?? ""
                    let img = data["img"] as? String ?? ""
                    
                    let achievement = Achievement(id: id, name: name, desc: desc, img: img)
                    self.achievements.append(achievement)
                }
                
            }
        }
    }
}




struct Achievement: Identifiable {
    var id: String
    var name: String
    var desc: String
    var img: String
}
