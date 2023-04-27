//
//  HistoryView.swift
//  Productive
//
//  Created by Weber, Til on 27.04.23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var dataManagerAch: DataManagerAchievements
    
    var body: some View {
        
        NavigationView {
            List(dataManager.groups, id: \.id){group in
                
                NavigationLink (destination: HistoryDetailView(pGroup: group)
                    .environmentObject(dataManagerAch)
                    .environmentObject(dataManager)) {
                        HStack{
                            Image(systemName: "person.fill")
                            Text(group.name)
                        }
                }

                
//                NavigationLink {
//                    HistoryDetailView(pGroup: group)
//                        .environmentObject(dataManagerAch)
//                } label: {
//                    HStack{
//                        Image(systemName: "person.fill")
//                        Text(group.name)
//                    }
//                }
                
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(DataManager())
            .environmentObject(DataManagerAchievements())
    }
}
