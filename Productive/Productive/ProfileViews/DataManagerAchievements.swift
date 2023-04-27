//
//  DataManagerAchievements.swift
//  Productive
//
//  Created by Weber, Til on 25.04.23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class DataManagerAchievements: ObservableObject {
    @Published var achievements: [Achievement] = []
    @Published var id: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var image: UIImage?
    @Published var oldImage: UIImage?
    @Published var path: String = ""
    @Published var user: User = User(id: "", firstname: "", lastname: "", groupIDs: [""], height: "", weight: "")
    
    
    init() {
        fetchAchievements()
        fetchUserData()
        user = User(id: id, firstname: firstname, lastname: lastname, groupIDs: [""], height: height, weight: weight)
    }
    
    func updateUser(pID: String){
        
        
        let db = Firestore.firestore()
        let ref = db.collection("user")
        ref.whereField("id", isEqualTo: pID).getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                let data = snapshot.documents[0].data()
                
                self.user = User(id: data["id"] as? String ?? "", firstname: data["firstname"] as? String ?? "", lastname: data["lastname"] as? String ?? "", groupIDs: data["groups"] as? [String] ?? [""], height: data["height"] as? String ?? "", weight: data["weight"] as? String ?? "")
            }
        }
    }
    
    func fetchUserData(){
        let email = Auth.auth().currentUser?.email as? String ?? ""
        self.id = Auth.auth().currentUser?.email as? String ?? ""
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
                self.weight = data["weight"] as? String ?? ""
                self.height = data["height"] as? String ?? ""
                self.path = data["pic"] as! String
                
                //get reference to profile picture in firebase storage
                let storageRef = Storage.storage().reference()
                let fileref = storageRef.child(self.path)
                fileref.getData(maxSize: 5 * 1024 * 1024) { dat, err in
                    if err == nil && dat != nil {
                        self.image = UIImage(data: dat!)
                        self.oldImage = UIImage(data: dat!)
                    }
                }
            }
        }
    }
    func updateUserData(){
        //return if no image is given
        guard self.image != nil else {
            return
        }
        let storageRef = Storage.storage().reference()
        let imageData = self.image!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        //specify file name
        let path = "ProfilePictures/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        
        //if profile picture has been changed, it will be updated in the database and the old will be deleted
        if self.oldImage?.jpegData(compressionQuality: 0.8) != self.image?.jpegData(compressionQuality: 0.8) {
            //delete old profile picture
            let oldfileRef = storageRef.child(self.path)
            oldfileRef.delete { err in
                if err != nil {
                    print(err!.localizedDescription)
                }
            }
            self.path = path
            //upload new profile picture and other changes to database / storage
            fileRef.putData(imageData!, metadata: nil) { metadata, error in
                if error == nil && metadata != nil {
                    let id = Auth.auth().currentUser!.uid
                    let db = Firestore.firestore()
                    let ref = db.collection("user").document(id)
                    ref.updateData([
                        "firstname": self.firstname,
                        "lastname": self.lastname,
                        "weight": self.weight,
                        "height": self.height,
                        "pic": path
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
        }
        else {
            //only update the other attributes if the profile picture remains the same
            let id = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            let ref = db.collection("user").document(id)
            ref.updateData([
                "firstname": self.firstname,
                "lastname": self.lastname,
                "weight": self.weight,
                "height": self.height
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
        
    }
    
    
    func fetchAchievements(){
        //currently: get all achievements
        //soon: also indicate, if the user has completed the achievements
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
