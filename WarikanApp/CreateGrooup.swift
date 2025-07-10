//
//  CreateGrooup.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/10.
//

import SwiftUI

struct CreateGrooup: View {
    @State private var groupName = ""
    @State private var memberName = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Color("main")
                        .frame(height: geometry.size.height / 8)
                        .edgesIgnoringSafeArea(.top)
                    VStack {
                        Text("グループ名")
                        //入力欄
                        TextField("グループ名", text: $groupName)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        Text("メンバー名")
                        HStack {
                            // 入力欄
                            TextField("メンバー名", text: $memberName)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                            Button {
                                print("メンバーを追加します")
                            } label: {
                                Text("追加")
                            }
                            
                        }
                        
                        Button {
                            print("ボタンが押されました")
                        } label: {
                            Text("グループを作成")
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
        }
    }
}

#Preview {
    CreateGrooup()
}
