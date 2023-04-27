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
    @State private var user = User(id: "", firstname: "", lastname: "", groupIDs: [""], height: "", weight: "", pic: "")
    @State private var items: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    init(pUser: String){
        userID = pUser
//        dataManagerAch.updateUser(pID: userID)
//        user = dataManagerAch.user
    }
    
    
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                if(dataManagerAch.userImage == nil) {
                    Image("IconTestDoner")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                        .scaledToFit()
                } else {
                    Image(uiImage: dataManagerAch.userImage!)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                        .scaledToFit()
                }
                    VStack (alignment: .leading){
                        Text(dataManagerAch.user.firstname + " " + dataManagerAch.user.lastname)
                            .font(.system(size: 30))
                        Text(dataManagerAch.user.id)
                            .font(.system(size: 20))
                    }
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 18))
                .padding()
                .foregroundColor(.black)
            
                ScrollView{
                    LazyVGrid(columns: items, spacing: 20) {
                        ForEach(dataManagerAch.achievements, id: \.id) { achievement in
                            
                                NavigationLink(destination: AchievementOverView(achievement: achievement)){
                                    VStack {
                                        Image(systemName: achievement.img)
                                        Text(achievement.name)
                                    }
                                    .foregroundColor(.black)
                                }
                            
                        }
                    }
                }
                .navigationTitle(dataManagerAch.user.firstname)
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
