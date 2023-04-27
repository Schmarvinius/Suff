//
//  GroupList.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import SwiftUI
import FirebaseFirestore



struct GroupList: View {
    
    @EnvironmentObject var dataManager : DataManager
    @EnvironmentObject var drinkDB: DrinkDB
    
    //let manager = CacheManager.instance
    
    var body: some View {
        List (dataManager.groups, id: \.id) {group in
            Button {
                MyLocalStorage().setValue(key: "currentSession", value: getSession(gid: group.id))
                let test2 = group.id
                let test = getSession(gid: group.id)
                drinkDB.fetchDrinksWSID(sID: MyLocalStorage().getValue(key: "currentSession"))
            } label: {
                HStack{
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.black)
                    Text(group.name)
                }
            }
        }
    }
    
    
    //function is returning without
    
    func getSession(gid: String) -> String {
        let db = Firestore.firestore()
        let ref = db.collection("drinksSession")
        let query = ref.whereField("gid", isEqualTo: gid)
        var id : String = "yqpUTddjiglEiREZ7IMl"
        query.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                let data = snapshot.documents[0].data()
                id = data["gid"] as? String ?? ""
            }
        }
        return id
        
    }

}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList()
            .environmentObject(DataManager())
    }
}
