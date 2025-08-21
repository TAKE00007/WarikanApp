//
//  ParticipantCircleView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/21.
//

import SwiftUI

struct ParticipantCircleView: View {
    
    let billing: Billing
    let billingParticipants: [BillingParticipant]
    let users: [User]
    
    var body: some View {
        HStack {
            ForEach(billingParticipants) { billingParticipant in
                if (billing.id == billingParticipant.billingId) {
                    if let user = users.first(where: { $0.id == billingParticipant.userId }), billingParticipant.isShare {
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
}

