//
//  GroupService.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/13.
//

import Foundation
import FirebaseFirestore

struct GroupService {
    private let groupRepository = GroupRepository()
    private let userRepository = UserRepository()
    
    func createGroupWithUsers(groupName: String, users:[User]) async throws -> Group {
        let newGroup = Group(groupName: groupName)
        try await groupRepository.addGroup(newGroup)

        let newUsers = users.map {
            User(groupId: newGroup.id, userName: $0.userName, isPay: $0.isPay)
        }
        
        try await userRepository.addUsers(newUsers)
        
        return newGroup
    }
    
    func fetchAllGroups() async throws -> [Group] {
        try await groupRepository.fetchAllGroups()
    }
    
}
