//
//  BillingParticipant.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation
import FirebaseFirestore

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

class BillingParticipantRepository {
    private let db = Firestore.firestore()
    
    func addBillingParticipant(_ billingParticipant: BillingParticipant) async throws {
        let documentId = "\(billingParticipant.billingId.uuidString)_\(billingParticipant.userId.uuidString)"
        
        try await db.collection("billingParticipants").document(documentId).setData([
            "billingId": billingParticipant.billingId.uuidString,
            "userId": billingParticipant.userId.uuidString,
            "groupId": billingParticipant.groupId.uuidString,
            "isShare": billingParticipant.isShare
        ])
    }
}
