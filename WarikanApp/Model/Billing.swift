//
//  Billing.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

struct Billing: Identifiable {
    var id = UUID()
    var userId: Int
    var groupId: Int
    var paymentPrice: Int
    var priceTitle: String
    var createdAt = Date()
}
