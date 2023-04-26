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
    
    @State private var items: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    @EnvironmentObject var dataManagerAch : DataManagerAchievements
   
    var body: some View {
            NavigationView(){
                VStack (alignment: .leading)  {
                    HStack (alignment: .top) {
                            
                            Image("IconTestDoner")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .scaledToFit()
                        
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
                        Button(action: {}) {
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
                    /*LazyVGrid(columns: items, spacing: 20) {
                        ForEach(dataManagerAch.achievements, id: \.id) { achievement in
                            Label(achievement.name, systemImage: achievement.img)
                        }
                    } */
                    List(dataManagerAch.achievements, id: \.id){achievement in
                        NavigationLink(destination: AchievementOverView(achievement: achievement)) {
                            HStack {
                                Image(systemName: achievement.img)
                                    .font(.system(size:20))
                                .foregroundColor(Color.black)
                                Text(achievement.name)
                            }
                        }
                    }
                     
                }
                .padding(.all)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Text("Your Profile")
                    .font(.system(size: 20))
                    .bold())
                .navigationBarItems(trailing: Button(action: {}, label: {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .bold()
                    }
                }))
            }
            .navigationBarBackButtonHidden(true)
        }
    
    
    }

struct AchievementView : View {
    
    @State private var ach : Achievement
    init(achievement: Achievement){
        self.ach = achievement
    }
    
    var body: some View {
        Text(ach.name)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        /*ProfileView()
            .environmentObject(DataManagerAchievements()) */
        WelcomePageView()
    }
}
