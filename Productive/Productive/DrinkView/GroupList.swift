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
    
//    let list: [Group] = [
//        Group(id: "1", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"]),
//        Group(id: "2", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"]),
//        Group(id: "3", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"]),
//        Group(id: "4", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"])
//    ]
    
    var body: some View {
        
        List (dataManager.groups, id: \.id) {group in
            Button {
                drinkDB.getSession(gid: group.id)
                MyLocalStorage().setValue(key: "currentSession", value: drinkDB.id[0]/*"yqpUTddjiglEiREZ7IMl"*/)
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
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList()
            .environmentObject(DataManager())
    }
}
