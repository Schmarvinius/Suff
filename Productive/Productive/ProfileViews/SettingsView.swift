//
//  SettingsView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI
import FirebaseAuth


struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    enum Language: String, CaseIterable, Identifiable {
        case german, english, spanish, latin
        var id: Self { self }
    }
    @State private var selectedLanguage: Language = .latin
    @State private var isSignedOut = false
    
    var body: some View {
        if isSignedOut {
            WelcomePageView()
            
        }
        else {
            settingView
        }
    }
    
    var settingView: some View {
        
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
                        Button(action: {
                            signOut()
                        }){
                            Label("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                    }
                    
                }
               
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            return
        }
        isSignedOut = true
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
