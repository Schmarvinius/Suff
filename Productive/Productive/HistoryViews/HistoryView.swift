//
//  HistoryView.swift
//  Productive
//
//  Created by Weber, Til on 27.04.23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        
        NavigationView {
            List(dataManager.groups, id: \.id){group in
                NavigationLink {
                    HistoryDetailView(pGroup: group)
                } label: {
                    HStack{
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color.black)
                        Text(group.name)
                    }
                }
                
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
    }
}
