//
//  GroupList.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import SwiftUI



struct GroupList: View {
    
    @EnvironmentObject var dataManager : DataManager
    
    let manager = CacheManager.instance
    
    let list: [Group] = [
        Group(id: "1", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"]),
        Group(id: "2", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"]),
        Group(id: "3", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"]),
        Group(id: "4", name: "besteGruppe", userIDs: ["till@till.de", "yannis@yannis.de","marvin@marvin.de"])
    ]
    
    var body: some View {
        
        NavigationView {
            List (dataManager.groups, id: \.id) {group in
                NavigationLink(destination: DrinkView()) {
                    HStack{
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color.black)
                        Text(group.name)
                            .onTapGesture {
                                print("tapped")
                                manager.addString(value: group.id, key: "currentGroup")
                                let test = manager.getString(key: "currentGroup")
                            }
                    }
                    
                }
                
            }
        }
    }
    
    var test: some View{
        Text("HI")
    }
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList()
            .environmentObject(DataManager())
    }
}
