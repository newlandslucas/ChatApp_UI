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
        VStack {
            
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
            .background(Color("ColorGrayDark"))
            
            Spacer(minLength: 0)
        }
        .background(Color("ColorBlueDark").ignoresSafeArea(.all, edges: .all))
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
