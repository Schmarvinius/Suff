//
//  ContentView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataManager = DataManager()
    @StateObject var dataManagerAch = DataManagerAchievements()
    @StateObject var addDataManager = AddDataManager()
    @StateObject var drinkDB = DrinkDB()
    
    var body: some View {
        TabView{
            DrinkView()
                .tabItem{
                    Label("Your Drinks", systemImage: "wineglass")
                }
                .environmentObject(drinkDB)
            GroupView()
                .tabItem{
                    Label("Group", systemImage: "person.3")
                }
                .environmentObject(dataManager)
                .environmentObject(addDataManager)
            HistoryView()
                .tabItem{
                    Label("History", systemImage: "placeholdertext.fill")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
                .environmentObject(dataManagerAch)
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
