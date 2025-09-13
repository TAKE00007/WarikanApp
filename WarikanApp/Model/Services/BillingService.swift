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
}
