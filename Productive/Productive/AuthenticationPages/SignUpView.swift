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
    @State private var accountExists: Bool = false;
    @State private var whichView: Int32 = 0;
    
    var body: some View {
        //if(isSignedUp){
        //    ContentView()
        //}
        //if (accountExists) {
        //    SignInView()
        //}
        switch whichView {
            case 1:
                ContentView()
            case 2:
                SignInView()
            default:
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
                    TextField("name", text: $username)
                    
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
                    Button(action: switchLogin){
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
                    let id: String = Auth.auth().currentUser?.uid ?? ""
                    
                    db.collection("user").document(id).setData([
                        "id": email,
                        "firstname": username,
                        "lastname": username,
                        "groups": [""],
                        "friends":[""],
                        "chats":[""]
                    ]) { err in
                        if err != nil {
                            print(err!.localizedDescription)
                        }
                        self.isSignedUp.toggle()
                        self.whichView = 1
                    }
                    
                
                }
            }
        }
        func switchLogin(){
            self.accountExists.toggle()
            self.whichView = 2
        }
    //bracket for View
    }

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
