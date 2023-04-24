//
//  SignInView.swift
//  Productive
//
//  Created by Weber, Til on 21.04.23.
//

import SwiftUI
import FirebaseAuth


struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loggedIn = false
    
    var body: some View {
        if loggedIn {
            ContentView()
        } else {
            notLoggedIn
            
        }
    }
    
    
    var notLoggedIn: some View {
        NavigationView{
            VStack{
                Image("IconTestDoner")
                Spacer()
                HStack {
                    Image(systemName: "person")
                    TextField("email", text: $email)
                        
                    }
                    .frame(minWidth: 0, maxWidth: 250)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.black)
                    .overlay(
                    RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("password", text: $password)
        
                    }
                    .frame(minWidth: 0, maxWidth: 250)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.black)
                    .overlay(
                    RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                
                Spacer()
                Button(action: signIn) {
                    Text("Sign In")
                        .frame(minWidth: 0, maxWidth: 250)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 4))
                    
                }
                .background(Color.clear)
                .cornerRadius(25)
                Spacer()
                Spacer()
                
                HStack {
                    Text("Forgot password?")
                    Button("Reset"){
                        
                    }
                }
                //bracket for V-Stack
                }
            //bracket for NavigationView
            }
    }
    func signIn(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                self.loggedIn.toggle()
                print("Test")
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
