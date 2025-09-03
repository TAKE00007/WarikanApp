//
//  Group.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation
import FirebaseFirestore

struct Group: Identifiable {
    let id = UUID()
    var groupName: String
    
    init(groupName: String) {
        self.groupName = groupName
    }
}

class GroupRepository {
    private let db = Firestore.firestore()
    
    func addGroup(_ group: Group) async throws {
        try await db.collection("groups").document(group.id.uuidString).setData([
            "groupName": group.groupName
        ])
    }
    
    func fetchGroup(byGroupId groupId: UUID) async throws -> Group? {
        let res = try await db.collection("groups").document(groupId.uuidString).getDocument()
        
        guard
            let data = res.data(),
            let groupName = data["groupName"] as? String
        else {
            return nil
        }
        
        return Group(groupName: groupName)
    }
    
    func updateGroup(_ group: Group) async throws {
        try await db.collection("groups").document(group.id.uuidString).updateData([
            "groupName": group.groupName
        ])
    }
}
