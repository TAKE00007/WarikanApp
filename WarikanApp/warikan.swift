//
//  warikan.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/09.
//

import Foundation

// 全体の支払い金額を求める
struct WarikanCalculate {
    let billings: [Billing]
    let users: [User]
    
    func warikanCalculate(billings: [Billing], users: [User], billingParticipants: [BillingParticipant]) -> [PaymentResult] {
        // まず全員のpayPriceを0にする
            for user in users {
                user.payPrice = 0
            }
        
        for billing in billings {
            calculatePriceByPerson(users: users, billing: billing, billingParticipants: billingParticipants)
        }
        let result = givePrice(users: users)
        
        return result
    }
    
    func calculatePriceByPerson(users: [User], billing: Billing, billingParticipants: [BillingParticipant]) {
        //billingIdと同じでかつisShareがtrueの人を探す
        var payNum = 0
        for billingParticipant in billingParticipants {
            if billing.id == billingParticipant.billingId && billingParticipant.isShare {
                payNum += 1
            }
        }
        
        guard payNum > 0 else { return }
        
        //一人当たりの金額を出す
        let priceByPerson = billing.paymentPrice / payNum
        
        //参加者ごとに金額計算
        for billingParticipant in billingParticipants {
            if billing.id == billingParticipant.billingId && billingParticipant.isShare {
                // 払った人はuser.payPriceをpriceByPersonだけーにする
                if let user = users.first(where: { $0.id == billingParticipant.userId }) {
                    if billingParticipant.userId == billing.userId {
                        user.payPrice += (priceByPerson - billing.paymentPrice)
                    } else {
                        user.payPrice += priceByPerson
                    }
                } else {
                    print("該当ユーザーが見つかりません")
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
            
            results.append(PaymentResult(from: giver, to: receiver, amount: payment))
            
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
