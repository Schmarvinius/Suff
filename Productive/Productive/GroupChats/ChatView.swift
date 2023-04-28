//
//  ChatView.swift
//  Productive
//
//  Created by Moser, Yannis on 27.04.23.
//

import SwiftUI

class ChatLogViewModel: ObservableObject{
    @Published var chatText : String = ""
    init(){
        
    }
    func handeleSend(){
        print(chatText)
        chatText = ""
        
    }
}

struct ChatView: View {
    
    @ObservedObject var vm = ChatLogViewModel()
    
    
    let chatUser: String?
    var body: some View {
            VStack{
                contentMessageView
                
                contentBottemBar
            }
            .navigationTitle(chatUser ?? "")
            .navigationBarTitleDisplayMode(.inline)
        
    }
    var contentMessageView: some View{
        ScrollView{
            ForEach(0..<20){ num in
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
    }
    
    var contentBottemBar: some View{
        HStack(spacing: 16){
            Image(systemName:"photo.on.rectangle")
                .font(.system(size:24))
                .foregroundColor(Color(.darkGray))
            ZStack{
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            // TextEditor(text: $chatText)
            //TextField("Description", text: $chatText)
            Button {
                vm.handeleSend()
                
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(12)
            

        }
        .padding(.horizontal)
        .padding(.vertical,8)
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(chatUser: "HI")
    }
}



