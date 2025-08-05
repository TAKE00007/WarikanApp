//
//  User.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

class User: ObservableObject, Identifiable {
    let id: UUID
    @Published var userName: String
    @Published var isPay = true
    
    init(id: UUID = UUID(), userName: String) {
        self.id = id
        self.userName = userName
    }
}

