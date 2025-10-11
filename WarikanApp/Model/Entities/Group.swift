//
//  Group.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

struct Group: Identifiable {
    let id: UUID
    var groupName: String
    
    init(id: UUID = UUID(), groupName: String) {
        self.id = id
        self.groupName = groupName
    }
}
