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
    var body: some View {
        NavigationView(){
            VStack{
                List(dataManager.friends, id: \.id){friend in
                    Button(action:{
                        addDataManager.addChat(user: friend, dataManager: dataManager)
                        
                    }, label:{
                        HStack{
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color.black)
                            Text(friend.firstname)
                            Text(friend.lastname)
                            Spacer()
                            NavigationLink("",destination: GroupView())
                                .environmentObject(dataManager)
                            
                        }
                    })
                }
            }
                .navigationTitle("Add Chat")
            
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
