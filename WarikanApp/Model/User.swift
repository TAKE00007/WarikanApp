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
    @Published var userName: String
    @Published var isPay: Bool
    @Published var payPrice = 0
    
    init(id: UUID = UUID(), userName: String, isPay: Bool = true) {
        self.id = id
        self.userName = userName
        self.isPay = isPay
    }
}

class UserRepository {
    private let db = Firestore.firestore()
    
    func addUser(_ user: User, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(user.id.uuidString).setData([
            "userName": user.userName,
            "isPay": user.isPay,
            "payPrice": user.payPrice
        ], completion: completion)
    }
}
