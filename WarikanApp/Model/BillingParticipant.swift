//
//  BillingParticipant.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

struct BillingParticipant: Identifiable {
    var id = UUID()
    var userId: Int
    var isShare: Bool
}
