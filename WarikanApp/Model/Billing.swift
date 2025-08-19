//
//  Billing.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

class Billing: ObservableObject,Identifiable {
    let id = UUID()
    @Published var userId: UUID
    @Published var groupId: UUID
    @Published var paymentPrice: Int
    @Published var priceTitle: String
    @Published var createdAt = Date()
    
    init(userId: UUID, groupId: UUID, paymentPrice: Int, priceTitle: String, createdAt: Date = Date()) {
        self.userId = userId
        self.groupId = groupId
        self.paymentPrice = paymentPrice
        self.priceTitle = priceTitle
        self.createdAt = createdAt
    }
}
