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
    
    var body: some View {
        
        List (dataManager.groups, id: \.id) {group in
            Button {
                print("Test")
                drinkDB.getSession(gid: group.id)
                MyLocalStorage().setValue(key: "currentSession", value: drinkDB.id)
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
