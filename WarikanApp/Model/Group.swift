//
//  Group.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/21.
//

import Foundation

class Group: ObservableObject, Identifiable {
    let id = UUID()
    @Published var groupName: String
    
    init(groupName: String) {
        self.groupName = groupName
    }
}
