//
//  GroupView.swift
//  Productive
//
//  Created by Lindner, Marvin on 20.04.23.
//

import SwiftUI

struct GroupView: View {
    @State var isGroup = false
    @EnvironmentObject var dataManager: DataManager
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
                        Text("Group")
                    }else{
                        contentChats
                    }
                }
                .navigationTitle(isGroup ? "Groups" : "Chats")
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action:{
            //add
        }, label:{ 
            Image(systemName: "plus")
        }
                                            ))
    }
    var contentChats: some View {
        List(dataManager.users, id: \.id){user in
            HStack{
                Image(systemName: "person.fill")
                    .font(.system(size:30))
                    .foregroundColor(Color.black)
                Text(user.firstname)
                Text(user.lastname)
            }
        }
    }
    
    
    
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
            .environmentObject(DataManager())
    }
}










/* struct GroupView: View {
 @State var isGroup = true
 
 
 var body: some View {
     NavigationView{
         ScrollView{
             VStack{
              Picker(selection: $isGroup, label: Text("Picker here")){
                  Text("Groups")
                      .tag(true)
                  Text("Chats")
                      .tag(false)
              }.pickerStyle(SegmentedPickerStyle())
              //Groups / Chats
              if(isGroup){
                  Button{
                      
                  }label: {
                      HStack{
                          Spacer()
                          Image(systemName: "person.fill")
                              .font(.system(size:30))
                              .foregroundColor(Color.white)
                          Text("Groupname")
                              .foregroundColor(Color.white)
                          Spacer()
                      }
                      .padding(.vertical, 14)
                      .background(Color.gray)
                  }
              }else{
                  Button{
                      
                  }label: {
                      HStack{
                          Spacer()
                          Image(systemName: "person.fill")
                              .font(.system(size:30))
                              .foregroundColor(Color.white)
                          Text("Person")
                              .foregroundColor(Color.white)
                          Spacer()
                      }
                      .padding(.vertical, 14)
                      .background(Color.gray)
                  }
              }
             }
             .padding()

             }
             .navigationTitle(isGroup ? "Groups" : "Chats")
             }
             .navigationTitle("Chats")
             
         }
     }
  */
