//
//  WelcomePageView.swift
//  Productive
//
//  Created by Weber, Til on 21.04.23.
//

import SwiftUI

struct WelcomePageView: View {
    var body: some View {
    
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
