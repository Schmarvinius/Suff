//
//  ProfileView.swift
//  Productive
//
//  Created by Weber, Til on 24.04.23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @State private var email = Auth.auth().currentUser?.email as? String ?? ""
    @State private var showPopover = false
    
    
    @State private var items: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @EnvironmentObject var dataManagerAch : DataManagerAchievements
   
    
    
    var body: some View {
            NavigationView(){
                VStack (alignment: .leading)  {
                    HStack (alignment: .top) {
                        if(dataManagerAch.image == nil) {
                            Image("IconTestDoner")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .scaledToFit()
                        } else {
                            Image(uiImage: dataManagerAch.image!)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .scaledToFit()
                        }
                            VStack (alignment: .leading){
                                Text(dataManagerAch.firstname + " " + dataManagerAch.lastname)
                                    .font(.system(size: 30))
                                Text(email)
                                    .font(.system(size: 20))
                            }
                            Spacer()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.black)
                    
                    HStack {
                        NavigationLink(destination: EditProfileView()) {
                            Text("Edit Profile")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 16))
                                .padding()
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                        }
                        .cornerRadius(25)
                        
                        Button(action: { }) {
                            Text("Share profile")
                            
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 16))
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                        }
                        .cornerRadius(25)
                    }
                    
                    Text("Achievements")
                        .bold()
                        .font(.system(size: 20))
                    ScrollView{
                        LazyVGrid(columns: items, spacing: 20) {
                            ForEach(dataManagerAch.achievements, id: \.id) { achievement in
                                
                                    NavigationLink(destination: AchievementOverView(achievement: achievement)){
                                        VStack {
                                            Image(systemName: achievement.img)
                                            Text(achievement.name)
                                        }
                                        .foregroundColor(.black)
                                    }
                                
                            }
                        }
                    }
                    
                    Spacer()
                     
                }
                .padding(.all)
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {}, label: {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                    }
                }))
            }
            .navigationBarBackButtonHidden(true)
        }
    
    
    }

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(DataManagerAchievements())
       // WelcomePageView()
    }
}
