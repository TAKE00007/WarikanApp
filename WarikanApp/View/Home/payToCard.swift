//
//  payToCard.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/12.
//

import SwiftUI

struct payToCard: View {
    let sendUserName: String
    let giveUserName: String
    let amount: Int
    var body: some View {
        HStack {
            Text("\(sendUserName)" + "→" + "\(giveUserName)")
                .padding()
            Spacer()
            Text("¥\(amount)")
                .padding()
        }
        Divider()
    }
}

//#Preview {
//    payToCard()
//}
