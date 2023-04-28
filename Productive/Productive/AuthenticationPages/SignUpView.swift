//
//  SignUpView.swift
//  Productive
//
//  Created by Weber, Til on 21.04.23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedUp: Bool = false;
    @State private var accountExists: Bool = false;
    @State private var whichView: Int32 = 0;
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var height = ""
    @State private var weight = ""
    
    //let manager = CacheManager.instance
    
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
                signUp
        }
    }
    var signUp : some View{
        VStack {
//            Image("IconTestDoner")
//                .resizable()
//                .cornerRadius(25)
            Form {
                Section (header: Text("account information")) {
                    HStack {
                        Image(systemName: "envelope")
                        TextField("e-mail", text: $email)
                        
                    }
                    HStack {
                        Image(systemName: "lock")
                        SecureField("password", text: $password)
                        
                    }
                }
                Section (header: Text("personal details")) {
                    HStack {
                        Image(systemName: "person")
                        TextField("firstname", text: $firstname)
                        
                    }
                    HStack {
                        Image(systemName: "person")
                        TextField("lastname", text: $lastname)
                        
                    }
                    HStack {
                        Image(systemName: "ruler")
                        TextField("height", text: $height)
                            .keyboardType(.numberPad)
                            .onReceive(Just(height)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0)}
                                if filtered != newValue {
                                    height = filtered
                                }
                            }
                        
                    }
                    HStack {
                        Image(systemName: "scalemass")
                        TextField("weight", text: $weight)
                            .keyboardType(.numberPad)
                            .onReceive(Just(weight)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0)}
                                if filtered != newValue {
                                    weight = filtered
                                }
                            }
                    }
                }
                Section {
                    
                    HStack {
                        Spacer()
                        Button(action: signup) {
                            Text("Sign Up")
                        }
                        Spacer()
                    }
                }
            }
            .scrollDisabled(true)
            .cornerRadius(25)
            HStack {
                Text("Already have an account?")
                Button(action: switchLogin){
                    Text("Login")
                }
            }.font(.system(size: 14))
        }
        .navigationTitle("New Account")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var isNotSignedUp: some View {
        NavigationView{
            VStack{
                Image("IconTestDoner")
                    .cornerRadius(20)
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
            let newMail = email.lowercased()
            Auth.auth().createUser(withEmail: newMail, password: password) { authResult, error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    let db = Firestore.firestore()
                    let id: String = Auth.auth().currentUser?.uid ?? ""
                    
                    db.collection("user").document(id).setData([
                        "id": newMail,
                        "firstname": firstname,
                        "lastname": lastname,
                        "groups": [""],
                        "friends":[""],
                        "chats":[""],
                        "height": height,
                        "weight": weight,
                        "uid": id,
                        "pic": "",
                        "sessions": [""]
                    ]) { err in
                        if err != nil {
                            print(err!.localizedDescription)
                        }
                        MyLocalStorage().setValue(key: "email", value: email)
                        MyLocalStorage().setValue(key: "password", value: password)
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
