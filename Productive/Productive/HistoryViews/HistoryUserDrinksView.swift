//
//  HistoryUserDrinksView.swift
//  Productive
//
//  Created by Weber, Til on 27.04.23.
//

import SwiftUI

struct HistoryUserDrinksView: View {
    
    @State private var userID: String
    @EnvironmentObject var dataManagerAch: DataManagerAchievements
    @State private var user = User(id: "", firstname: "", lastname: "", groupIDs: [""], height: "", weight: "")
    
    init(pUser: String){
        userID = pUser
//        dataManagerAch.updateUser(pID: userID)
//        user = dataManagerAch.user
    }
    
    
    var body: some View {
        VStack {
            Text(dataManagerAch.user.firstname  + " " + dataManagerAch.user.lastname)
        }
        .onAppear{ refresh() }
        
            
    }
    func refresh(){
        dataManagerAch.updateUser(pID: userID)
        user = dataManagerAch.user
    }
        
}

struct HistoryUserDrinksView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(DataManager())
            .environmentObject(DataManagerAchievements())
    }
}
