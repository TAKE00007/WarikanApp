//
//  UserRepository.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/13.
//

import Foundation
import FirebaseFirestore

class UserRepository {
    private let db = Firestore.firestore()
    
    func addUser(_ user: User) async throws {
        try await db.collection("users").document(user.id.uuidString).setData([
            "groupId": user.groupId.uuidString,
            "userName": user.userName,
            "isPay": user.isPay,
            "payPrice": user.payPrice
        ])
    }
    
    func addUsers(_ users: [User]) async throws {
        let batch = db.batch()
        let col = db.collection("users")
        
        for user in users {
            let doc = col.document(user.id.uuidString)
            batch.setData([
                "groupId": user.groupId.uuidString,
                "usersName": user.userName,
                "isPay": user.isPay,
                "payPrice": user.payPrice
            ], forDocument: doc)
        }
        
        try await batch.commit()
    }
    
    func fetchUsers(byGroupId groupId: UUID) async throws -> [User] {
        let snapshot = try await db.collection("users")
            .whereField("groupId", isEqualTo: groupId.uuidString)
            .getDocuments()
        
        let users: [User] = snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard
                let groupIdString = data["groupId"] as? String,
                let groupUUID = UUID(uuidString: groupIdString),
                let userName = data["userName"] as? String,
                let isPay = data["isPay"] as? Bool,
                let payPrice = data["payPrice"] as? Int
            else {
                return nil
            }
            
            let user = User(
                id: UUID(uuidString: doc.documentID) ?? UUID(),
                groupId: groupUUID,
                userName: userName,
                isPay: isPay
            )
            user.payPrice = payPrice
            return user
        }
        
        return users
    }
    
    func updateUser(_ user: User) async throws {
        try await db.collection("users").document(user.id.uuidString).updateData([
            "userName": user.userName,
        ])
    }
    
}
