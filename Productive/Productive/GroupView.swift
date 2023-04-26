//
//  GroupView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI

struct GroupView: View {
    @State var isGroup = false
    @State var showAddChat = false
    @State var showAddGroup = false
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var addDataManager: AddDataManager
    
    var body: some View {
        NavigationView{
            VStack{
                Picker(selection: $isGroup, label: Text("Picker here")){
                    Text("Groups")
                        .tag(true)
                    Text("Chats")
                        .tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                if isGroup {
                    contentGroups
                }else{
                    contentChats
                }
            }
            .navigationTitle(isGroup ? "Groups" : "Chats")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {}, label: {
                if isGroup{
                    NavigationLink(destination: AddGroupView()) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .bold()
                    }
                } else{
                    NavigationLink(destination: AddChatView()) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .bold()
                    }
                }
            }))
                
                
                
                
                /*if(isGroup){
                    NavigationLink("+", destination: AddGroupView())
                        .environmentObject(dataManager)
                        .environmentObject(addDataManager)
                } else{
                    NavigationLink("+", destination: AddChatView())
                        .environmentObject(dataManager)
                        .environmentObject(addDataManager)
                }*/
                
               
                
            
        }
        
        
    }
    var contentChats: some View {
        List(dataManager.chats, id: \.id){chat in
            Button(action:{
                print("SKR SKR IN MEINEM AUDI")
            }, label:{
                HStack{
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.black)
                    Text(chat.firstname)
                    Text(chat.lastname)
                }
            })
        }
    }
    
    var contentGroups: some View {
        List(dataManager.groups, id: \.id){group in
            Button(action:{
                print("HI")
            }, label:{
                HStack{
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.black)
                    Text(group.name)
                }
            })
        }
        
    }
}
    struct GroupView_Previews: PreviewProvider {
        static var previews: some View {
            GroupView()
                .environmentObject(DataManager())
                .environmentObject(AddDataManager())
                
        }
    }
    
