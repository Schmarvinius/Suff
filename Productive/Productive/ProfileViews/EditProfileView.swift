//
//  EditProfileView.swift
//  Productive
//
//  Created by Weber, Til on 26.04.23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine
struct EditProfileView: View {
    @State private var email = Auth.auth().currentUser?.email as? String ?? ""
    @State private var showPopover = false
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var height = ""
    @State private var weight = ""
    
    @State private var image: UIImage?
    @State private var showDialog = false
    
    @State private var isDone = false
    @State private var isCanceled = false
    
    @EnvironmentObject var dataManagerAch : DataManagerAchievements
    
    var body: some View {
        if(isCanceled || isDone) {
            ProfileView()
        }
        else {
            editMode
        }
    }
    
    var editMode: some View {
            NavigationView(){
                
                    //Text(dataManagerAch.firstname + " " + dataManagerAch.lastname)
                VStack {
                    HStack(alignment: .center) {
                        
                        Spacer()
                        if dataManagerAch.image != nil {
                            Image(uiImage: dataManagerAch.image!)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .scaledToFit()
                                .onTapGesture {
                                    showDialog = true
                                }
                        } else {
                            Image("IconTestDoner")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 120, height: 120)
                                .scaledToFit()
                                .onTapGesture {
                                    showDialog = true
                                }
                        }
                        Spacer()
                    }
                    Form {
                        Section(header: Text("Personal Information")){
                            TextField("firstname", text: $dataManagerAch.firstname)
                            TextField("lastname", text: $dataManagerAch.lastname)
                        }
                        Section(header: Text("Measuring details")){
                            TextField("height", text: $dataManagerAch.height)
                                .keyboardType(.numberPad)
                                .onReceive(Just(dataManagerAch.height)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0)}
                                    if filtered != newValue {
                                        dataManagerAch.height = filtered
                                    }
                                }
                            TextField("weight", text: $dataManagerAch.weight)
                                .keyboardType(.numberPad)
                                .onReceive(Just(dataManagerAch.weight)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0)}
                                    if filtered != newValue {
                                        dataManagerAch.weight = filtered
                                    }
                                }
                        }
                        
                    }
                    .sheet(isPresented: $showDialog, content: {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $dataManagerAch.image)
                    })
                    .scrollDisabled(true)
                    .cornerRadius(20)
                    .padding(.all)
                    .navigationBarBackButtonHidden(true)
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button(action: {}, label: {
                        Button(action: {
                            dataManagerAch.updateUserData()
                            isDone = true
                        }) {
                            Text("Done")
                        }
                    }))
                    .navigationBarItems(leading: Button(action: {}, label: {
                        Button(action: {
                            dataManagerAch.fetchUserData()
                            isCanceled = true
                        }) {
                            Text("Cancel")
                        }
                    }))
                }
                }
                
            .navigationBarBackButtonHidden(true)
        }
    
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(DataManagerAchievements())
    }
}
