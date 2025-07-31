//
//  Billing.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

class Billing: Identifiable {
    let id = UUID()
    var userId: Int
    var groupId: Int
    var paymentPrice: Int
    var priceTitle: String
    var createdAt = Date()
    
    init(userId: Int, groupId: Int, paymentPrice: Int, priceTitle: String, createdAt: Date = Date()) {
        self.userId = userId
        self.groupId = groupId
        self.paymentPrice = paymentPrice
        self.priceTitle = priceTitle
        self.createdAt = createdAt
    }
}
