//
//  BillingService.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/13.
//

import Foundation

struct BillingService {
    private let billingRepository = BillingRepository()
    private let billingParticipantRepository = BillingParticipantRepository()
    
    func createBillingWithParticipants(billing: Billing, billingParticipants: [BillingParticipant])  async throws {
        try await billingRepository.addBilling(billing)
        try await billingParticipantRepository.addBillingParticipants(billingParticipants)
    }
    
    private func updateBillingWithParticipants(billing: Billing, billingParticipants: [BillingParticipant]) async {
        guard !isSaving else { return }
        guard let userId = userId else {
            errorMessage = "ユーザーが選択されていません"; return
        }
        //trimmingCharacters: 両端の空白を削除する
        guard !paymentTitle.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "項目名を入力してください"; return
        }
        guard let price = Int(paymentText), price >= 0 else {
            errorMessage = "金額は数値で入力してください"; return
        }
        
        isSaving = true
        defer { isSaving = false }
        
        //billing更新
        billing.userId = userId
        billing.priceTitle = paymentTitle
        billing.paymentPrice = price
        
        //billingParticipantを更新
        let targets: [BillingParticipant] = billingParticipants
            .filter { $0.billingId == billing.id }
            .map { part in
                part.isShare = users.first { $0.id == part.userId }?.isPay ?? true
                return part
            }
        
        //払う人(billing.userId)が選択されているけどチェックが外れている場合(billingParticipants.isShare=falseを排除
        if let targetIsShare = billingParticipants
            .first (where: { $0.userId == billing.userId && $0.billingId == billing.id })?.isShare, targetIsShare == false {
            errorMessage = "支払い者のチェックが外れています"; return
            }
        
        do {
            let repo = BillingRepository()
            try await repo.updateBillingWithParticipants(billing: billing, participants: targets)
            dismiss()
        } catch {
            errorMessage = "更新に失敗しました: \(error.localizedDescription)"
        }
    }
}
