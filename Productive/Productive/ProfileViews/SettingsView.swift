//
//  SettingsView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    enum Language: String, CaseIterable, Identifiable {
        case german, english, spanish, latin
        var id: Self { self }
    }
    @State private var selectedLanguage: Language = .english
    
    
    
    var body: some View {
        
        NavigationView {
                Form {
                    Section(header: Text("Appearance")) {
                        Toggle(isOn: $isDarkModeEnabled) {
                            Text("DarkMode")
                        }
                        Picker("Language", selection: $selectedLanguage){
                            Text("German").tag(Language.german)
                            Text("English").tag(Language.english)
                            Text("Spanish").tag(Language.spanish)
                            Text("Latin").tag(Language.latin)
                        }
                    }
                    Section(header: Text("Account settings")){
                        Button(action: {}){
                            Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                    }
                    
                }
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
