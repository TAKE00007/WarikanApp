//
//  BillingCard.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/05.
//

import SwiftUI

struct BillingCard: View {
    
    let billing: Billing
    let users: [User]
    
    var body: some View {
        Button {
            print("ボタンが押されました")
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(billing.priceTitle)
                        .foregroundColor(Color.black)
                    // TODO: createdAtのformatterをmm/ddにする
                    Text("\(getUserName(by: billing.userId, from: users) ?? "不明")が立替え(\(DateFormatter.monthDay.string(from: billing.createdAt)))")
                        .foregroundColor(Color.gray)
                    Text("マーク")
                }
                
                Spacer()
                
                Text("¥\(billing.paymentPrice)")
                    .foregroundColor(Color.black)
                    .padding()
                NavigationLink(destination: UpdateRegisterView()) {
                    Image(systemName: "pencil")
                        .foregroundColor(Color.black)
                        .bold()
                        .font(.system(size: 20))
                }
            }
        }

        Divider()
    }
}

private func getUserName(by id: UUID, from users: [User]) -> String? {
    return users.first { $0.id == id }?.userName
}
