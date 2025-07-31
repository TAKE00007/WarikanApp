//
//  UserTag.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/31.
//

import SwiftUI

struct UserTag: View {
    let user: User
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text(user.userName)
            Button(action: onDelete){
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Color.gray)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(Color.white)
        .overlay(
            Capsule().stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .clipShape(Capsule())
    }
}

//#Preview {
//    UserTag()
//}
