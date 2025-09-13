//
//  BillingParticipantRepository.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/13.
//

import Foundation
import FirebaseFirestore

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
    
    func fetchBillingParticipants(byGroupId groupId: UUID) async throws -> [BillingParticipant] {
        let snapshot = try await db.collection("billingParticipants")
            .whereField("groupId", isEqualTo: groupId.uuidString)
            .getDocuments()
        
        let billingParticipants: [BillingParticipant] = snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard
                let billingIdString = data["billingId"] as? String,
                let billingUUID = UUID(uuidString: billingIdString),
                let userIdString = data["userId"] as? String,
                let userUUID = UUID(uuidString: userIdString),
                let groupIdString = data["groupId"] as? String,
                let groupUUID = UUID(uuidString: groupIdString),
                let isShare = data["isShare"] as? Bool
            else {
                return nil
            }
            
            let billingParticipant = BillingParticipant(
                billingId: billingUUID,
                userId: userUUID,
                groupId: groupUUID,
                isShare: isShare
            )
            return billingParticipant
        }
        return billingParticipants
    }
    
    func updateBillingParticipant(_ billingParticipant: BillingParticipant) async throws {
        let documentId = "(\(billingParticipant.billingId.uuidString)_\(billingParticipant.userId.uuidString))"
        try await db.collection("billingParticipants").document(documentId).updateData([
            "isShare": billingParticipant.isShare
        ])
    }
}
