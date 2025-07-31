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
    
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 400), spacing: 10,),
        GridItem(.adaptive(minimum: 100, maximum: 400), spacing: 10,),
        GridItem(.adaptive(minimum: 100, maximum: 400), spacing: 10,),
        GridItem(.adaptive(minimum: 100, maximum: 400), spacing: 10,),
        
    ]
    
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
                                let newUser = User(userName: user.userName)
                                users.append(newUser)
                                user.userName = ""
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
                        
                        FlowLayout(items: users) { user in
                            HStack(spacing: 4) {
                                Text(user.userName)
                                Button{
                                    if let index = users.firstIndex(where: { $0.id == user.id }) {
                                        users.remove(at: index)
                                    }
                                } label: {
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

struct FlowLayout<Content: View, T: Identifiable>: View {
    var items: [T]
    var spacing: CGFloat
    var content: (T) -> Content
    
    //@ViewBuilder：クロージャの中で複数のViewを返せるようにするSwiftUIの機能
    //@escapingの部分があまりよくわからない
    init(items: [T], spacing: CGFloat = 8, @ViewBuilder content: @escaping (T) -> Content) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    
    private func generateContent(in geo: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(items) { item in
                content(item)
                    .padding(4)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if abs(width - dimension.width) > geo.size.width {
                            width = 0
                            height -= dimension.height + spacing
                        }
                        let result = width
                        width -= dimension.width + spacing
                        return  result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        return result
                    })
            }
        }
    }
}
