//
//  Billing.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

struct Billing: Identifiable {
    let id = UUID()
    var userId: UUID
    var groupId: UUID
    var paymentPrice: Int
    var priceTitle: String
    var createdAt = Date()
    
    init(userId: UUID, groupId: UUID, paymentPrice: Int, priceTitle: String, createdAt: Date = Date()) {
        self.userId = userId
        self.groupId = groupId
        self.paymentPrice = paymentPrice
        self.priceTitle = priceTitle
        self.createdAt = createdAt
    }
}
