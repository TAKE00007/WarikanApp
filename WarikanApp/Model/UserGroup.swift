//
//  UserGroup.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

class UserGroup: ObservableObject {
    @Published var groupId: Int
    @Published var userId: Int
    
    init(groupId: Int, userId: Int) {
        self.groupId = groupId
        self.userId = userId
    }
}
