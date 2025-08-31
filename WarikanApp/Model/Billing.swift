//
//  Billing.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation
import FirebaseFirestore

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

class BillingRepository {
    private let db = Firestore.firestore()
    
    func addBilling(_ billing: Billing) async throws {
        try await db.collection("billings").document(billing.id.uuidString).setData([
            "userId": billing.userId.uuidString,
            "groupId": billing.groupId.uuidString,
            "paymentPrice": billing.paymentPrice,
            "priceTitle": billing.priceTitle,
        ])
    }
}
