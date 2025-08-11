//
//  warikan.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/09.
//

import Foundation

private let user1 = User(userName: "take")
private let user2 = User(userName: "aoi")
private let user3 = User(userName: "kaoru")
private let group = Group(groupName: "北海道旅行")
private let users: [User] = [user1, user2, user3]

private let billing1 = Billing(userId: user1.id, groupId: group.id, paymentPrice: 1000, priceTitle: "タクシー")
private let billing2 = Billing(userId: user2.id, groupId: group.id, paymentPrice: 5000, priceTitle: "駐車場代")
private let billing3 = Billing(userId: user3.id, groupId: group.id, paymentPrice: 3000, priceTitle: "車代")

private let billingByGroup = BillingByGroup(billingByGroup: [billing1, billing2, billing3])

// 全体の支払い金額を求める
struct WarikanCalculate {
    let billingByGroup: BillingByGroup
    
    
    
    
    func calculateTotalAmount(billingByGroup: BillingByGroup) -> Int {
        var totalAmount = 0
        billingByGroup.billingByGroup.forEach { billing in
            totalAmount += billing.paymentPrice
        }
        
        return totalAmount
    }
    
    
}
