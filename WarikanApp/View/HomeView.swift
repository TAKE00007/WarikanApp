//
//  Home.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/02.
//

import SwiftUI

struct HomeView: View {
    let group: Group
    let users: [User]
    //親が初期化したObservableObjectを保持
    @StateObject private var billingGroupBy = BillingByGroup(billingByGroup: [])

    
    var body: some View {
        NavigationStack {
            HeaderView(group: group, users: users)
            VStack {
                NavigationLink(destination: RegisterView(
                    groupId: group.id,
                    billingGroupBy: billingGroupBy,
                    users: users)
                ) {
                    Text("立替え記録を追加")
                        .bold()
                        .padding(.horizontal, 120)
                        .padding(.vertical, 12)
                        .foregroundStyle(Color("main"))
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color("main"), lineWidth: 2)
                        )
                }

                //支払い記録を表示
                ForEach(billingGroupBy.billingByGroup, id: \.id) { billing in
                    BillingCard(billing: billing, users: users)
                }
//                Button {
//                    print("ボタンが押されました")
//                } label: {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text("タクシー代")
//                                .foregroundColor(Color.black)
//                            Text("たけが立替え(07/08)")
//                                .foregroundColor(Color.gray)
//                            Text("マーク")
//                        }
//                        
//                        Spacer()
//                        
//                        Text("¥4,800")
//                            .foregroundColor(Color.black)
//                            .padding()
//                        NavigationLink(destination: UpdateRegisterView()) {
//                            Image(systemName: "pencil")
//                                .foregroundColor(Color.black)
//                                .bold()
//                                .font(.system(size: 20))
//                        }
//                    }
//                }
//                
//                Divider()
                
                Spacer()
                
                Button {
                    print("ボタンが押されました")
                } label: {
                    Text("明細を見る")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 350, height: 55)
                        .foregroundStyle(Color.black)
                        .background(Color("back"))
                        .cornerRadius(3)
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

#Preview {
    HomeView(
        group: Group(groupName: "北海道旅行"),
        users: [User(userName: "たけ"),User(userName: "あおい"), User(userName: "かおる")],
    )
}
