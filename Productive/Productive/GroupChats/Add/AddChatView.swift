//
//  AddChatView.swift
//  Productive
//
//  Created by Moser, Yannis on 25.04.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddChatView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var addDataManager: AddDataManager
    
    @State private var addFriend = true
    
    @State private var newFriend = ""
    
    var body: some View {
        VStack {
            Picker(selection: $addFriend, label: Text("Picker here")){
                Text("Friend")
                    .tag(true)
                Text("Chat")
                    .tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if addFriend {
                contentFriend
            }
            else {
                contentChat
            }
        }
        .navigationTitle("Add")
        .navigationBarTitleDisplayMode(.inline)
    }
    var contentFriend: some View {
        Form {
            Section (header: Text("email")){
                TextField("email", text: $newFriend)
            }
            Section {
                Button(action: {}) {
                    HStack {
                        Spacer()
                        Text("Add Friend")
                        Spacer()
                    }
                }
            }
        }
    }
    var contentChat: some View {
        Form {
            List(dataManager.friends, id: \.id){friend in
                Button(action:{
                    addDataManager.addChat(user: friend, dataManager: dataManager)
                    
                }, label:{
                    HStack{
                        Image(systemName: "person.fill")
                            .foregroundColor(Color.black)
                        Text(friend.firstname)
                        Text(friend.lastname)
                        Spacer()
                        NavigationLink("",destination: GroupView())
                            .environmentObject(dataManager)
                        
                    }
                    .foregroundColor(.black)
                })
            }
        }
    }
}

struct AddChatView_Previews: PreviewProvider {
    static var previews: some View {
        AddChatView()
            .environmentObject(DataManager())
            .environmentObject(AddDataManager())
    }
}
