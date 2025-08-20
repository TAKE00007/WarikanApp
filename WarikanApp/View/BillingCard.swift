//
//  BillingCard.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/05.
//

import SwiftUI

struct BillingCard: View {
    
    @Binding var  billing: Billing
    @Binding var billings: [Billing]
    @Binding var billingParticipants: [BillingParticipant]
    let users: [User]
    
    var body: some View {
        Button {
            print("ボタンが押されました")
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(billing.priceTitle)
                        .foregroundColor(Color.black)
                    Text("\(getUserName(by: billing.userId, from: users) ?? "不明")が立替え(\(DateFormatter.monthDay.string(from: billing.createdAt)))")
                        .foregroundColor(Color.gray)
                    HStack {
                        ForEach(billingParticipants) { billingParticipant in
                            if (billing.id == billingParticipant.billingId) {
                                if let user = users.first(where: { $0.id == billingParticipant.userId }) {
                                    let name = user.userName.prefix(1)
                                    ZStack {
                                        Circle()
                                            .stroke(Color.blue, lineWidth: 2)
                                            .frame(width: 25, height: 25)
                                        
                                        Text("\(name)")
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                Text("¥\(billing.paymentPrice)")
                    .foregroundColor(Color.black)
                    .padding()
                NavigationLink(
                    destination: UpdateRegisterView(
                        users: users,
                        billing: $billing,
                        billings: $billings,
                        billingParticipants: $billingParticipants
                    )
                ) {
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
