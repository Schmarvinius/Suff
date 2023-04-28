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
                
        if auth {
            ContentView()
        } else {
            main
        }
        
    }
    init() {
        isAuthenticated(email: MyLocalStorage().getValue(key: "email"), password: MyLocalStorage().getValue(key: "password"))
        MyLocalStorage().setValue(key: "currentSession", value: MyLocalStorage().getValue(key: "currentSession"))
    }
    @State var auth : Bool = false
    func isAuthenticated(email: String, password: String) {
        
        if (email != "" && password != "") {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.auth = false
                    print(error!.localizedDescription)
                    print("Error in auth")
                } else {
                    self.auth = true
                    print("Authenticated successfully")
                }}
            } else {
                self.auth = false
                print("No cache data")
            }
        }
    
    
    var main: some View {
        
        NavigationView{
            
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Image("IconTestDoner")
                        .cornerRadius(20)
                        
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
