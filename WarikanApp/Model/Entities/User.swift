//
//  User.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

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
