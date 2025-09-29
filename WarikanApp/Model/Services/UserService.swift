//
//  UserService.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/13.
//

import Foundation

struct UserService {
    private let userRepository = UserRepository()
    private let billingRepository = BillingRepository()
    private let billingParticipantRepository = BillingParticipantRepository()
    
    func loadUsersWithBillings(groupId: UUID) async throws -> homeData {
        async let loadUsers = userRepository.fetchUsers(byGroupId: groupId)
        async let loadBillings = billingRepository.fetchBillings(byGroupId: groupId)
        async let loadBillingParticipants = billingParticipantRepository.fetchBillingParticipants(byGroupId: groupId)
        let (users, billings, billingParticipants) = try await (loadUsers, loadBillings, loadBillingParticipants)
        
        return homeData(users: users, billings: billings, billingParticipants: billingParticipants)
    }
    
    func addUser(user: User) async throws {
        try await userRepository.addUser(user)
    }
    
    
}

struct homeData {
    let users: [User]
    let billings: [Billing]
    let billingParticipants: [BillingParticipant]
}
