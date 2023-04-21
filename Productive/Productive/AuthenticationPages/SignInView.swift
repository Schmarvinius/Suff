//
//  SignInView.swift
//  Productive
//
//  Created by Weber, Til on 21.04.23.
//

import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Image("IconTestDoner")
                Spacer()
                HStack {
                    Image(systemName: "person")
                    TextField("username/email", text: $username)
                        
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
                NavigationLink(destination: ContentView()) {
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
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
