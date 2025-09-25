//
//  ShishutuListView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/23.
//

import SwiftUI

struct ShishutuListView: View {
    let userList: [(String, Int)]
    var totalAmount: Int {
        userList.map { $0.1 }.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            VStack {
                ForEach (userList, id: \.0) { (name, amount) in
                    HStack {
                        Text(name)
                        Spacer()
                        Text("\(amount)")
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
                Text("\(totalAmount)")
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
