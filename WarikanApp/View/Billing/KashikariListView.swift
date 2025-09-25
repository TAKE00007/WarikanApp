//
//  KashikariListView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/23.
//

import SwiftUI

struct KashikariListView: View {
    let kashikariList: [(String, Int)]
    
    var body: some View {
        VStack { 
            VStack {
                ForEach(kashikariList, id: \.0) { (name, amount) in
                    HStack {
                        Text(name)
                        Spacer()
                        Text("\(amount < 0 ? "-" : "")¥\(abs(amount))")
                            .foregroundStyle(amount >= 0 ? .blue : .red)
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

//#Preview {
//    KashikariListView()
//}
