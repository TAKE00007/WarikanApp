//
//  UserRow.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/31.
//

import SwiftUI

struct UserRow: View {
    @ObservedObject var user: User
    
    var body: some View {
        HStack {
            Button {
                user.isPay.toggle()
            } label: {
                if user.isPay {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color("main"))
                } else {
                    Image(systemName: "square")
                        .foregroundColor(Color("back"))
                }
            }
            .fontWeight(.bold)
            .font(.title)
            Text(user.userName)
        }
        .padding()
    }
}
//#Preview {
//    UserRow()
//}
