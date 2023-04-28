//
//  SignInView.swift
//  Productive
//
//  Created by Weber, Til on 21.04.23.
//

import SwiftUI
import FirebaseAuth


struct SignInView: View {
    @State public var email: String = "till@till.de"
    @State private var password: String = "123456"
    @State private var loggedIn = false
    
    //let manager = CacheManager.instance
    
    var body: some View {
        if loggedIn {
            ContentView()
        } else {
//            notLoggedIn
            contentSignIn
            
        }
    }
    var contentSignIn: some View {
        VStack {
            Image("IconTestDoner")
                .cornerRadius(25)
            Form {
                Section (header: Text("Account Details")){
                    HStack {
                        Image(systemName: "person")
                        TextField("email", text: $email)
                    }
                    HStack {
                        
                        Image(systemName: "lock")
                        SecureField("password", text: $password)
                    }
                    
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: signIn) {
                            Text("Sign In")
                        }
                        Spacer()
                    }
                }
            }
            .scrollDisabled(true)
            .cornerRadius(25)
            HStack {
                Text("Forgot password?")
                Button("Reset"){
                    
                }
            }
        }
    }
    
    
    
    var notLoggedIn: some View {
        NavigationView{
            VStack{
                Image("IconTestDoner")
                    .cornerRadius(20)
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
        let newMail = email.lowercased()
        Auth.auth().signIn(withEmail: newMail, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                MyLocalStorage().setValue(key: "email", value: email)
                MyLocalStorage().setValue(key: "password", value: password)
                self.loggedIn.toggle()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
