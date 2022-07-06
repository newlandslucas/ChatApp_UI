//
//  HomeView.swift
//  ChatApp_UI
//
//  Created by Lucas Machado (Estudos) on 04/07/22.
//

import SwiftUI

struct Home: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Namespace var animation
    
    @State var selectedTab = "Chats"
    var body: some View {
        VStack(spacing: 0) {
            
            VStack {
                ZStack {
                    HStack {
                        
                        Button {
                            print("")
                        } label: {
                            Image(systemName: "camera")
                                .font(.system(size: 22))
                        }
                        Spacer(minLength: 0)
                        
                        Button {
                            print("")
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 22))
                        }
                    }
                    
                    Text("UIChat")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                }
                .foregroundColor(.white)
                .padding()
                .padding(.top, 45)
                
                HStack(spacing: 20) {
                    
                    ForEach(tabs, id: \.self) {title in
                        
                        TabButton(selectedTab: $selectedTab, title: title, animation: animation)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.08))
                .cornerRadius(15)
                .padding(.vertical)
                
            }
            .padding(.bottom)
            .background(Color("ColorBlueDark"))
            .clipShape(CustomCorner(corner: .bottomLeft, size: 65))
            
            ZStack {
                Color("ColorBlueDark")
                
                Color(.white)
                    .clipShape(CustomCorner(corner: .topRight, size: 65))
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 20) {
                        
                        HStack {
                            Text("All Chats")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                                    .font(.system(size: 22))
                                    .foregroundColor(.primary)
                            }

                        }
                        .padding()
                        
                        ForEach(data, id: \.groupName) {gData in
                            HStack {
                                
                                Text(gData.groupName)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal)
                            
                            ForEach(gData.groudData){chatData in
                                ChatView(chatData: chatData)
                            }
                                                        
                        }
                    }
                    .padding(.vertical)
                })
            }
        }
        .background(Color(.white).ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
    }
}

var tabs = ["Chats", "Status", "Calls"]

struct TabButton: View {
    @Binding var selectedTab: String
    var title : String
    var animation : Namespace.ID
 
    var body: some View {
        
        Button {
            
            withAnimation {
                selectedTab = title
            }
        } label: {
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal)
            
                // Sliding Efect...
                .background(
                
                
                ZStack {
                    if selectedTab == title {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("ColorGrayDark"))
                            .matchedGeometryEffect(id: "tab", in: animation)
                    }
                }
            )
        }

    }
}

struct CustomCorner: Shape {
    
    var corner: UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct ChatView: View {
    
    var chatData: Chat
    var body: some View {
        
        HStack(spacing: 10) {
            
            Image(chatData.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(chatData.name)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(chatData.msg)
                    .font(.caption)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
            Spacer(minLength: 0)
            
            Text(chatData.time)
                .font(.system(size: 12))
                .fontWeight(.semibold)
        }
        .padding(.horizontal)
    }
}

struct Chat: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var image: String
    var msg: String
    var time: String
    
}

struct HomeData {
    
    var groupName: String
    var groudData: [Chat]
    
}

var FriendsChat : [Chat] = [
    Chat(name: "Barbara Dias", image: "p1", msg: "Hey honey, how are you?", time: "14:45"),
    Chat(name: "Carlos Arthur", image: "p2", msg: "hi son, how are you?", time: "15:45"),
    Chat(name: "Eduarda Silveira", image: "p3", msg: "Hi Lucas...", time: "16:55"),
    Chat(name: "Bill Gates", image: "p4", msg: "Founder of Microsoft", time: "19:00"),
    Chat(name: "Tim Cook", image: "p5", msg: "Apple Inc CEO", time: "21:00")
]

var GroupChat : [Chat] = [
    Chat(name: "Barbara Dias", image: "p1", msg: "Hey honey, how are you?", time: "14:45"),
    Chat(name: "Carlos Arthur", image: "p2", msg: "hi son, how are you?", time: "15:45"),
    Chat(name: "Eduarda Silveira", image: "p3", msg: "Hi Lucas...", time: "16:55"),
    Chat(name: "Bill Gates", image: "p4", msg: "Founder of Microsoft", time: "19:00"),
    Chat(name: "Tim Cook", image: "p5", msg: "Apple Inc CEO", time: "21:00")
]

var data = [
    HomeData(groupName: "Friends", groudData: FriendsChat),
    HomeData(groupName: "Group Message", groudData: GroupChat)
]

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
