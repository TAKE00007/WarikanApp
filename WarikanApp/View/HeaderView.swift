//
//  HeaderView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/02.
//

import SwiftUI

struct HeaderView: View {
    let group: Group
    let users: [User]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("main")
                .frame(maxWidth: .infinity)
                .frame(height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(group.groupName)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    Spacer()
                    NavigationLink(destination: UpdateCreateGroupView()) {
                        Image(systemName: "pencil")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.black)
                    }
                }
                
                HStack(spacing: 4) {
                    ForEach(users, id: \.id) { user in
                        Text(user.userName)
                            .foregroundColor(.white)
                        if  user.id != users.last?.id {
                            Text("・")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    HeaderView(group: Group(groupName: "北海道旅行"), users: [User(userName: "たけ"), User(userName: "あおい"), User(userName: "かおる")])
}
