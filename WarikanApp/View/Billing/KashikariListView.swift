//
//  KashikariListView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/23.
//

import SwiftUI

struct KashikariListView: View {
    let users: [User] = [
        User(id: UUID(), groupId: UUID(), userName: "take", isPay: true),
        User(id: UUID(), groupId: UUID(), userName: "sho", isPay: false)
    ]
    let prices: [Int] = [
        20081,-20081
    ]
    
    var body: some View {
        VStack { 
            VStack {
                ForEach(0..<min(users.count, prices.count), id: \.self) { i in
                    let user = users[i]
                    let price = prices[i]
                    
                    HStack {
                        Text(user.userName)
                        Spacer()
                        Text("\(price < 0 ? "-" : "")¥\(abs(price))")
                            .foregroundStyle(price >= 0 ? .blue : .red)
                    }
                    .padding()
                    Divider()
                }
                
            }
            .listStyle(.plain)
            
            
            (
                Text("青字").foregroundStyle(.blue)
                + Text("は受け取るべき金額 / ")
                + Text("赤字").foregroundStyle(.red)
                + Text("は支払うべき金額")
            )
            .padding()
            
            
        }
    }
}

#Preview {
    KashikariListView()
}
