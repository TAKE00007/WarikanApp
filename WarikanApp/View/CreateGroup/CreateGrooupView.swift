//
//  CreateGrooup.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/10.
//

import SwiftUI

struct CreateGrooupView: View {
    @StateObject private var user = User(groupId: UUID(), userName: "")
    @State private var group = Group(groupName: "")
    @State private var userName: String = ""
    @State private var users: [User] = []
    @FocusState private var isUserNameFocused: Bool
    
    @State private var navigateToHome = false
    @State private var createdGroup: Group?
    
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
                            TextField("メンバー名", text: $userName)
                                .padding(15)
                                .focused($isUserNameFocused)
                            
                            
                            Button {
                                if !userName.isEmpty {
                                    let newUser = User(groupId: group.id, userName: userName)
                                    users.append(newUser)
                                    userName = ""
                                    isUserNameFocused = false
                                }
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
                        PreviewUserName(users: $users)
                        
                        //グループ作成
                        Button {
                            Task {
                                await saveGroup()
                                navigateToHome = true
                            }
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
                        
                        //画面遷移
                        .navigationDestination(isPresented: $navigateToHome) {
                            HomeView(group: $group)
                        }
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
    
    private func saveGroup() async {
        do {
            //group
            let newGroup = Group(groupName: group.groupName)
            let groupRepo = GroupRepository()
            try await groupRepo.addGroup(newGroup)
            
            //users
            //groupIdをnewGroup.idに変更してから保存する
            let userRepo = UserRepository()
            for user in users {
                let fixedUser = User(groupId: newGroup.id, userName: user.userName)
                try await userRepo.addUser(fixedUser)
            }
            
            //成功した時
            group = newGroup
            createdGroup = newGroup
            navigateToHome = true
        } catch {
            print("保存失敗: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CreateGrooupView()
}

