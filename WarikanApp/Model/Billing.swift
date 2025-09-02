//
//  Billing.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation
import FirebaseFirestore

struct Billing: Identifiable {
    let id: UUID
    var userId: UUID
    let groupId: UUID
    var paymentPrice: Int
    var priceTitle: String
    var createdAt = Date()
    
    init(id: UUID = UUID(), userId: UUID, groupId: UUID, paymentPrice: Int, priceTitle: String, createdAt: Date = Date()) {
        self.id = id
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
    
    func fetchBillings(byGroupId groupId: UUID) async throws -> [Billing] {
        let snapshot = try await db.collection("billings")
            .whereField("groupId", isEqualTo: groupId.uuidString)
            .getDocuments()
        
        let billings: [Billing] = snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard
                let userIdString = data["userId"] as? String,
                let userUUID = UUID(uuidString: userIdString),
                let groupIdString = data["groupId"] as? String,
                let groupUUID = UUID(uuidString: groupIdString),
                let paymentPrice = data["paymentPrice"] as? Int,
                let priceTitle = data["priceTitle"] as? String
            else {
                return nil
            }
            
            let billing = Billing(
                id: UUID(uuidString: doc.documentID) ?? UUID(),
                userId: userUUID,
                groupId: groupUUID,
                paymentPrice: paymentPrice,
                priceTitle: priceTitle
            )
            return billing
        }
        
        return billings
    }
}
