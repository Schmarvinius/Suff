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
    @State var retrievedImages = [UIImage]()
    @State var pathscopy = [String]()
    @State var image : UIImage?
    
    /*@State var list : [Drink] = [
        Drink(id: "1", name: "Test1", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 250),
        Drink(id: "2", name: "Test2", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 300),
        Drink(id: "3", name: "Test3", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 120),
        Drink(id: "4", name: "Test4", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 250),
        Drink(id: "5", name: "Test5", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 300),
        Drink(id: "6", name: "Test6", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 250),
        Drink(id: "7", name: "Test7", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 300),
        Drink(id: "8", name: "Test8", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 250),
        Drink(id: "9", name: "Test9", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 300),
        Drink(id: "10", name: "Test10", pic: "DrinksImages/F534618C-71FA-496B-A2EF-2596A49E8886.jpg", volume: 250),
    ]*/
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    List(drinkdb.drinks, id: \.id){ item in
                        NavigationLink{
                            DetailView(name: item.name, volume: item.volume, pic: item.pic)
                        } label: {
                            HStack{
                                //Image(uiimage: retrievedImage!)
                                RoundedRectangle(cornerRadius: 10)
                                   .frame(maxWidth: 50, maxHeight: 50)
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
        }
        .onAppear{
            //drinkdb.fetchDrinks()
            //retrieveImages()
        }
        
    }
    
    func retrieveImages() {
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
                    
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, err in
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
    }
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView()
            .environmentObject(DrinkDB())
    }
}
