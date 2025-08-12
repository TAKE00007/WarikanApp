//
//  payToCard.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/12.
//

import SwiftUI

struct payToCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("精算方法")
                    .bold()
                    .padding()
                Spacer()
                Text("共有用にコピー")
                    .padding()
            }
            HStack {
                Text("あおい" + "→" + "たけ")
                    .padding()
                Spacer()
                Text("¥1,600")
                    .padding()
            }
            Divider()
            HStack {
                Text("かおる" + "→" + "たけ")
                    .padding()
                Spacer()
                Text("¥1,600")
                    .padding()
            }

        }
    }
}

#Preview {
    payToCard()
}
