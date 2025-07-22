//
//  CreateGrooup.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/10.
//

import SwiftUI

struct CreateGrooup: View {
    @StateObject private var group = Group(groupName: "")
    @StateObject private var user = User(userName: "")
    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Color("main")
                        .frame(height: geometry.size.height / 8)
                        .edgesIgnoringSafeArea(.top)
                    VStack {
                        Text("グループ名")
                            .frame(maxWidth: 350, alignment: .leading)

                        //入力欄
                        TextField("グループ名", text: $group.groupName)
                            .padding(15)
                            .background(Color.white)
                            .frame(width: 350)
                            .padding(.bottom, 20)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                        
                        Text("メンバー名")
                            .frame(maxWidth: 350, alignment: .leading)
                        HStack(spacing: 0) {
                            // 入力欄
                            TextField("メンバー名", text: $user.userName)
                                .padding(15)
                            
                            Button {
                                print("メンバーを追加します")
                                users.append(user)
                                print(users)
                            } label: {
                                Text("追加")
                                    .bold()
                                    .padding(.horizontal ,24)
                                    .padding(.vertical, 15)
                                    .foregroundStyle(Color.white)
                                    .background(Color("main"))

                            }
                            
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                        .frame(width: 350)
                        .padding(.bottom, 40)
                        
                        //名前一覧
                        
                        Button {
                            print("ボタンが押されました")
                        } label: {
                            Text("グループを作成")
                                .bold()
                                .padding(.horizontal, 120)
                                .padding(.vertical, 12)
                                .foregroundStyle(Color.white)
                                .background(Color("main"))
                                .cornerRadius(3)
                        }
                        .padding(.top, 100)

                        
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Walican")
                                .foregroundColor(Color.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(Color("main"), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    CreateGrooup()
}
