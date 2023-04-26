//
//  ContentView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var drinksDB = drinkDB()
    var body: some View {
            TabView{
                DrinkView()
                    .tabItem{
                        Label("Your Drinks", systemImage: "wineglass")
                    }
                    .environmentObject(drinksDB)
                GroupView()
                    .tabItem{
                        Label("Group", systemImage: "person.3")
                    }
                HistoryView()
                    .tabItem{
                        Label("History", systemImage: "placeholdertext.fill")
                    }
                SettingsView()
                    .tabItem{
                        Label("Profile", systemImage: "person")
                    }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
