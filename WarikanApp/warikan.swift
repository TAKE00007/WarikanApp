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

private let billingParticipant_1_1 = BillingParticipant(billingId: billing1.id, userId: user1.id, isShare: true)
private let billingParticipant_1_2 = BillingParticipant(billingId: billing1.id, userId: user2.id, isShare: true)
private let billingParticipant_1_3 = BillingParticipant(billingId: billing1.id, userId: user3.id, isShare: true)

private let billingParticipant_2_1 = BillingParticipant(billingId: billing2.id, userId: user1.id, isShare: true)
private let billingParticipant_2_2 = BillingParticipant(billingId: billing2.id, userId: user2.id, isShare: true)
private let billingParticipant_2_3 = BillingParticipant(billingId: billing2.id, userId: user3.id, isShare: true)

private let billingParticipant_3_1 = BillingParticipant(billingId: billing3.id, userId: user1.id, isShare: true)
private let billingParticipant_3_2 = BillingParticipant(billingId: billing3.id, userId: user2.id, isShare: true)
private let billingParticipant_3_3 = BillingParticipant(billingId: billing3.id, userId: user3.id, isShare: true)


private let billingByGroup = BillingByGroup(billingByGroup: [billing1, billing2, billing3])
private let billingParticipants = [billingParticipant_1_1, billingParticipant_1_2, billingParticipant_1_3,
                                   billingParticipant_2_1, billingParticipant_2_2, billingParticipant_2_3,
                                   billingParticipant_3_1, billingParticipant_3_2, billingParticipant_3_3,
                                   ]

// 全体の支払い金額を求める
struct WarikanCalculate {
    let billingByGroup: BillingByGroup
    let users: [User]
    
    
    
    
    func calculateTotalAmount(billingByGroup: BillingByGroup) -> Int {
        var totalAmount = 0
        billingByGroup.billingByGroup.forEach { billing in
            totalAmount += billing.paymentPrice
        }
        
        return totalAmount
    }
    
    func calculatePriceByPerson(users: [User], billing: Billing, billingParticipants: [BillingParticipant]) {
        //billingIdと同じでかつisShareがtrueの人を探す
        var payNum = 0
        for billingParticipant in billingParticipants {
            if billing.id == billingParticipant.billingId || billingParticipant.isShare {
                payNum += 1
            }
        }
        
        //一人当たりの金額を出す
        let priceByPerson = billing.paymentPrice / payNum
        for billingParticipant in billingParticipants {
            if billing.id == billingParticipant.billingId || billingParticipant.isShare {
                // 払った人はuser.payPriceをpriceByPersonだけーにする
                if billingParticipant.userId == billing.userId {
                    
                    //後からお金を受け取る人は一人当たりの金額-合計の値段をもつ
                    if let payUser = users.first(where: { $0.id == billing.userId }) {
                        payUser.payPrice = priceByPerson - billing.paymentPrice
                    } else {
                        print("該当ユーザーが見つかりません")
                    }
                } else {
                    if let payUser = users.first(where: { $0.id == billing.userId }) {
                        payUser.payPrice += priceByPerson
                    } else {
                        print("該当ユーザーが見つかりません")
                    }
                }
                
            }
        }
    }
    
    func givePrice(users: [User]) -> [PaymentResult] {
        var results: [PaymentResult] = []
        
        //受け取る側
        var receivers = users.filter { $0.payPrice < 0 }
            .map { ($0, -$0.payPrice) }
        
        //あげる側
        var givers = users.filter { $0.payPrice > 0 }
            .map { ($0, $0.payPrice) }
        
        var receiverIndex = 0
        var giverIndex = 0
        
        while receiverIndex < receivers.count && giverIndex < givers.count {
            var (receiver, needAmount) = receivers[receiverIndex]
            var (giver, giveAmount) = givers[giverIndex]
            
            let payment = min(needAmount, giveAmount)
            
            results.append(PaymentResult(from: giver, to: receiver, amout: payment))
            
            //残高更新
            needAmount -= payment
            giveAmount -= payment
            
            receivers[receiverIndex].1 = needAmount
            givers[giverIndex].1 = giveAmount
            
            if needAmount == 0 {
                receiverIndex += 1
            }
            
            if giveAmount == 0 {
                giverIndex += 1
            }
        }
        
        return results
    }
}

struct PaymentResult {
    let from: User
    let to: User
    let amout: Int
}
