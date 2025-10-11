//
//  BillingParticipant.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

class BillingParticipant: Identifiable {
    let billingId: UUID
    var userId: UUID
    var groupId: UUID
    var isShare: Bool
    
    init(billingId: UUID, userId: UUID, groupId: UUID, isShare: Bool) {
        self.billingId = billingId
        self.userId = userId
        self.groupId = groupId
        self.isShare = isShare
    }
}
