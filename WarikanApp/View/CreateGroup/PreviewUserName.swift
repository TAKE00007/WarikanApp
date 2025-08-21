//
//  PreviewUserName.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/31.
//

import SwiftUI

struct PreviewUserName: View {
    @Binding var users: [User]
    
    var body: some View {
        VStack(alignment: .leading) {
            FlowLayout(spacing: 8, lineSpacing: 8,) {
                ForEach(users, id: \.id) { user in
                    UserTag(user: user) {
                        if let index = users.firstIndex(where: { $0.id == user.id }) {
                            users.remove(at: index)
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    PreviewUserName()
//}
