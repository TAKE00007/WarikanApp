//
//  PaymentResult.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/13.
//

import Foundation

struct PaymentResult: Identifiable {
    let id = UUID()
    let from: User
    let to: User
    let amount: Int
}
