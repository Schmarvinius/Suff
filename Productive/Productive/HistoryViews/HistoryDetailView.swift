//
//  HistoryDetailView.swift
//  Productive
//
//  Created by Weber, Til on 27.04.23.
//

import SwiftUI

struct HistoryDetailView: View {
    @State private var group: Group
    @State private var isUser = true
    @State private var groupUsers : [String]
    @State private var isOnDetail = false
    @EnvironmentObject var dataManagerAch: DataManagerAchievements
    @EnvironmentObject var dataManger : DataManager
    init(pGroup: Group){
        group = pGroup
        groupUsers = pGroup.userIDs
        
    }
    
    var body: some View {
            VStack {
                Picker(selection: $isUser, label: Text("Picker here")){
                    Text("User")
                        .tag(true)
                    Text("Statistics")
                        .tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
            .padding()
                if isUser {
                    contentUser
                }
                else {
                    contentStats
                }
            }
           
            .navigationTitle(group.name)
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    var contentUser: some View {
        
            List(groupUsers, id: \.self){ user in
                    NavigationLink(
                            destination: HistoryUserDrinksView(pUser: user)
                                .environmentObject(dataManagerAch)) {
                        HStack{
                            Image(systemName: "person.fill")
                            Text(user)
                        }
                    }
//                    .onTapGesture {
//                        print("test")
//                        dataManagerAch.updateUser(pID: user)
//                        print(dataManagerAch.user)
////                    }
//                    .simultaneousGesture(TapGesture().onEnded({  dataManagerAch.updateUser(pID: user)
//                    }))
//
            }
        
    }
    var contentStats: some View {
        Text("Hello Stats")
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        HistoryDetailView()
        HistoryView()
            .environmentObject(DataManager())
            .environmentObject(DataManagerAchievements())
    }
}
