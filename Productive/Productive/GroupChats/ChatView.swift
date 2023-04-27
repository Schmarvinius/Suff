//
//  ChatView.swift
//  Productive
//
//  Created by Moser, Yannis on 27.04.23.
//

import SwiftUI

struct ChatView: View {
    @State var chatText : String = ""
    let chatUser: String?
    var body: some View {
        NavigationView {
            VStack{
                ScrollView{
                    ForEach(0..<10){ num in
                        HStack{
                            Spacer()
                            HStack{
                                Text("Some fake Message")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        
                        .padding(.horizontal)
                        .padding(.top,4)
                        
                        HStack{Spacer()}
                        
                    }
                    .background(Color(.init(white: 0.95, alpha: 1)))
                }
                HStack(spacing: 16){
                    Image(systemName:"photo.on.rectangle")
                        .font(.system(size:24))
                        .foregroundColor(Color(.darkGray))
                    // TextEditor(text: $chatText)
                    TextField("Description", text: $chatText)
                    Button {
                        //send ChatText
                    } label: {
                        Text("Send")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(4)
                    

                }
                .padding(.horizontal)
                .padding(.vertical,8)
                
            }
            .navigationTitle(chatUser ?? "")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(chatUser: "HI")
    }
}
