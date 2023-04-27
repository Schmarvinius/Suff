//
//  GroupView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI
import FirebaseAuth

struct GroupView: View {
    @State var isGroup = false
    @State var showAddChat = false
    @State var showAddGroup = false
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var addDataManager: AddDataManager
    @EnvironmentObject var dataManagerAch : DataManagerAchievements
    
    var body: some View {
        NavigationView{
            VStack(){
                HStack(){
                   // if(dataManagerAch.image == nil) {
                        Image("IconTestDoner")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .scaledToFit()
                   /* } else {
                        Image(uiImage: dataManagerAch.image!)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width:60, height: 60)
                            .scaledToFit()
                    }*/
                    VStack(alignment: .leading, spacing: 4){
                        HStack{
                            Text(dataManager.userFirstname)
                            .font(.system(size:24, weight: .bold))
                            Text(dataManager.userLastname)
                            .font(.system(size:24, weight: .bold))
                            
                        }
                        HStack{
                            Circle()
                                .foregroundColor(Color(.green))
                                .frame(width: 14)
                                .shadow(radius: 1)
                            Text("online")
                                .font(.system(size:14))
                                .foregroundColor(Color(.lightGray))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                
                
                
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
        }
        
        
    }
    var contentChats: some View {
        List(dataManager.chats, id: \.id){chat in
            Button(action:{
                print("SKR SKR IN MEINEM AUDI")
            }, label:{
                
                VStack{
                    HStack{
                        Image(systemName: "person.fill")
                            .font(.system(size: 45))
                            .foregroundColor(Color.black)
                        VStack(alignment: .leading){
                            HStack{
                                Text(chat.firstname)
                                    .font(.system(size: 16, weight: .bold))
                                Text(chat.lastname)
                                    .font(.system(size: 16, weight: .bold))
                            }
                            Text("Message from User")
                                .font(.system(size: 16))
                                .foregroundColor(Color(.lightGray  ))

                        }
                        Spacer()
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                        
                    }
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
//    func getPic (path : String){
//        let storageRef = Storage.storage().reference()
//        let fileref = storageRef.child(path)
//        fileref.getData(maxSize: 5 * 1024 * 1024) { dat, err in
//            if err == nil && dat != nil {
//                self.image = UIImage(data: dat!)
//            }
//        }
//    }
    
    
    
    
}
    struct GroupView_Previews: PreviewProvider {
        static var previews: some View {
            GroupView()
                .environmentObject(DataManager())
                .environmentObject(AddDataManager())
                .environmentObject(DataManagerAchievements())
                
        }
    }
    
