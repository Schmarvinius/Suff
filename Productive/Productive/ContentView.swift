//
//  ContentView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataManager = DataManager()
    var body: some View {
        TabView{
            DrinkView()
                .tabItem{
                    Label("Your Drinks", systemImage: "person")
                }
            GroupView()
                .tabItem{
                    Label("Group", systemImage: "person.3")
                }
                .environmentObject(dataManager)
            HistoryView()
                .tabItem{
                    Label("History", systemImage: "placeholdertext.fill")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
