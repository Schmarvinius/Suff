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
    
    var body: some View {
        List (dataManager.groups, id: \.id) {group in
            HStack{
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(Color.black)
                Text(group.name)
            }
            .onTapGesture {
                manager.addString(value: group.name, key: "currentGroup")
                let g = manager.getString(key: "currentGroup")
                //route to drink view (contentview)
                let test = manager.getString(key: "email")
                let test2 = manager.getString(key: "password")
            }
        }
    }
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList()
    }
}
