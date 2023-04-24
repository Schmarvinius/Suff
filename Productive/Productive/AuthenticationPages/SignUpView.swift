//
//  SignUpView.swift
//  Productive
//
//  Created by Weber, Til on 21.04.23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedUp: Bool = false;
    
    var body: some View {
        if(isSignedUp){
            ContentView()
        }
        else {
            isNotSignedUp
        }
    }
    
    var isNotSignedUp: some View {
        NavigationView{
            VStack{
                Image("IconTestDoner")
                Spacer()
                HStack {
                    Image(systemName: "person")
                    TextField("username", text: $username)
                    
                }
                .frame(minWidth: 0, maxWidth: 250)
                .font(.system(size: 18))
                .padding()
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                
                HStack {
                    Image(systemName: "envelope")
                    TextField("e-mail", text: $email)
                    
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
                
                HStack {
                    Text("Already have an account?")
                    NavigationLink(destination: SignInView()) {
                        Text("Login")
                    }
                }.font(.system(size: 14))
                
                Spacer()
                Button(action: signup) {
                    Text("Sign Up")
                        .frame(minWidth: 0, maxWidth: 250)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25).stroke(Color.blue, lineWidth: 4))
                    
                }
                .background(Color.blue)
                .cornerRadius(25)
                Spacer()
                
            
                //bracket for V-Stack
                }
            //bracket for NavigationView
            }
        
        //bracket for View-Body
        }
        func signup(){
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    let db = Firestore.firestore()
                    db.collection("user").addDocument(data: [
                        "id": email,
                        "firstname": username,
                        "lastname": username
                    ]) { err in
                        if err != nil {
                            print(err!.localizedDescription)
                        }
                        self.isSignedUp.toggle()
                    }
                    
                }
                
            }
        }
    //bracket for View
    }

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
