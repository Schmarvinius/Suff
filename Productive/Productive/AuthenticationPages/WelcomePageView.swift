//
//  WelcomePageView.swift
//  Productive
//
//  Created by Weber, Til on 21.04.23.
//

import SwiftUI
import FirebaseAuth

struct WelcomePageView: View {
    
    var body: some View {
        let manager = CacheManager.instance
        
        if isAuthenticated(email: manager.getString(key: "email"), password: manager.getString(key: "password")) {
            ContentView()
        } else {
            main
        }
        
    }
    init() {
        let manager = CacheManager.instance
        
        //isAuthenticated(email: manager.getString(key: "email"), password: manager.getString(key: "password"))
    }
    func isAuthenticated(email: String, password: String) -> Bool {
        var auth : Bool = false
        if (email != "" && password != "") {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                    auth = false
                    print("error in auth")
                } else {
                    auth = true
                    print("worked")
                }}
            } else {
                auth = false
                print("no cache data")
            }
            return auth
        }
    
    
    var main: some View {
        
        NavigationView{
            
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Image("IconTestDoner")
                        
                    Spacer()
                    Text("Welcome!")
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .frame(minWidth: 0, maxWidth: 250)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25).stroke(Color.blue, lineWidth: 2))
                        
                    }
                    .background(Color.blue)
                    .cornerRadius(25)
                    
                    NavigationLink(destination: SignInView()){
                        Text("Sign In")
                            .frame(minWidth: 0, maxWidth: 250)
                            .font(.system(size: 18))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                    }
                    .background(Color.white)
                    .cornerRadius(25)
                    Spacer()
                    Spacer()
                }
            }
        
        }
        
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
