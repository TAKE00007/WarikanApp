//
//  ShishutuListView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/23.
//

import SwiftUI

struct ShishutuListView: View {
//    let users: [User] = [
//        User(id: UUID(), groupId: UUID(), userName: "take", isPay: true),
//        User(id: UUID(), groupId: UUID(), userName: "sho", isPay: false)
//    ]
    let users: [User]
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
                        Text("\(price)")
                    }
                    .padding()
                    Divider()
                }
                
            }
            .listStyle(.plain)
            
            HStack {
                Text("グループ支出合計")
                    .bold()
                Spacer()
                Text("¥277919")
                    .bold()
            }
            .padding()
            
            Divider()
        }
    }
}

//#Preview {
//    ShishutuListView()
//}
