//
//  BillingParticipant.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

class BillingParticipant: Identifiable {
    let id = UUID()
    var userId: Int
    var isShare: Bool
    
    init(userId: Int, isShare: Bool) {
        self.userId = userId
        self.isShare = isShare
    }
}
