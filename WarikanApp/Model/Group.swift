//
//  Group.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation
import FirebaseFirestore

struct Group: Identifiable {
    let id: UUID
    var groupName: String
    
    init(id: UUID = UUID(), groupName: String) {
        self.id = id
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
    
    func fetchAllGroups() async throws -> [Group] {
        let snapshot = try await db.collection("groups").getDocuments()
        let groups: [Group] = snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard
                let groupName = data["groupName"] as? String,
                !groupName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            else {
                return nil
            }
            
            let group = Group(
                id: UUID(uuidString: doc.documentID) ?? UUID(),
                groupName: groupName
            )
            return group
        }
        
        return groups
    }
    
    func updateGroup(_ group: Group) async throws {
        try await db.collection("groups").document(group.id.uuidString).updateData([
            "groupName": group.groupName
        ])
    }
}
