//
//  User.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation
import FirebaseFirestore

class User: ObservableObject, Identifiable {
    let id: UUID
    let groupId: UUID
    @Published var userName: String
    @Published var isPay: Bool
    @Published var payPrice = 0
    
    init(id: UUID = UUID(),groupId: UUID, userName: String, isPay: Bool = true) {
        self.id = id
        self.groupId = groupId
        self.userName = userName
        self.isPay = isPay
    }
}

class UserRepository {
    private let db = Firestore.firestore()
    
    func addUser(_ user: User) async throws {
        try await db.collection("users").document(user.id.uuidString).setData([
            "groupId": user.groupId,
            "userName": user.userName,
            "isPay": user.isPay,
            "payPrice": user.payPrice
        ])
    }
}
