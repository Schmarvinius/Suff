//
//  DrinkView.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage


struct DrinkView: View {
    
    @EnvironmentObject var drinkdb : DrinkDB
    @EnvironmentObject var dataManager : DataManager
    
    @State var retrievedImages = [UIImage]()
    @State var pathscopy = [String]()
    @State var image : UIImage?
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    @State var isInSession : Bool = true
    
    //let manager = CacheManager.instance
    
    init() {
        print(MyLocalStorage().getValue(key: "currentSession"))
    }
    
    var body: some View {
        if isInSession {
            Joined
                .environmentObject(dataManager)
                .onAppear{
                    drinkdb.fetchDrinksWSID(sID: MyLocalStorage().getValue(key: "currentSession"))
                }
        } else {
            notJoined
                .environmentObject(dataManager)
                .environmentObject(drinkdb)
                
        }
    }
    
    var Joined: some View {
        NavigationStack {
            ZStack{
                VStack{
                     List(drinkdb.drinks, id: \.id){ item in
                        NavigationLink{
                            DetailView(name: item.name, volume: item.volume, pic: item.pic)
                                .environmentObject(drinkdb)
                        } label: {
                            HStack{
                     //Image(uiimage: retrievedImage!)
                                ZStack{
                                    Rectangle()
                                        .frame(maxWidth: 50, maxHeight: 50)
                                        .cornerRadius(10)
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                        .scaleEffect(1)
                                }
                                .padding(.trailing, 5)
                                Text(item.name)
                            }
                        }.frame(height: 50)
                    }
                }
                
                VStack{
                    Spacer()
                    NavigationLink(destination: AddView(), label: {
                        Text("Add a drink")
                            .frame(width: 300)
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    })
                    .padding()
                }
            }
            .navigationTitle("Your Drinks")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: NavigationLink{
                notJoined
            } label: {
                Text("Change")
            })
        }
        .onAppear{
            //drinkdb.fetchDrinksWSID(sID: MyLocalStorage().getValue(key: "currentSession"))
        }
    }
    
    var notJoined: some View {
        List (dataManager.groups, id: \.id) {group in
            Button {
                drinkdb.getSession(gid: group.id)
                MyLocalStorage().setValue(key: "currentSession", value: drinkdb.id[0]/*"yqpUTddjiglEiREZ7IMl"*/)
                drinkdb.fetchDrinksWSID(sID: MyLocalStorage().getValue(key: "currentSession"))
            } label: {
                HStack{
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.black)
                    Text(group.name)
                }
            }
        }
    }

    
    /*func retrieveImages() {
        let db = Firestore.firestore()
        
        db.collection("drink").getDocuments { snapshot, err in
            
            if err == nil && snapshot != nil {
                var paths = [String]()
                
                for doc in snapshot!.documents {
                    paths.append(doc["pic"] as! String)
                    pathscopy.append(doc["pic"] as! String)
                }
                
                for path in pathscopy {
                    
                    let storageRef = Storage.storage().reference()
                    
                    let fileRef = storageRef.child(path)
                    
                    fileRef.getData(maxSize: 1 * 1024 * 1024) { data, err in
                        if err == nil && data != nil {
                            if let image = UIImage(data: data!) {
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                            }
                        }
                    }
                }
            }
        }
    }*/
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView()
            .environmentObject(DrinkDB())
            .environmentObject(DataManager())
    }
}
