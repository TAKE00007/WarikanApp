//
//  Register.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/17.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedIndex = 1
    let groupId: UUID
    @Binding var billingGroupBy: BillingByGroup
    @State private var priceTitle = ""
    @State private var paymentPrice = 0
    @State private var userId = UUID()
    
    let users: [User]
    
    //最大2列までのレイアウト
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // 名前選択部分
                HStack(spacing: 5) {
                    Menu {
                        ForEach(users.indices, id: \.self) { index in
                            Button(action: {
                                selectedIndex = index
                                userId = users[selectedIndex].id
                            }) {
                                Text(users[index].userName)
                            }
                        }
                    } label: {
                        HStack {
                            Text(users[selectedIndex].userName)
                                .foregroundColor(Color.black) // カスタムカラー指定可
                            Spacer()
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(Color.black)
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .frame(width: 200)
                        .background(Color("background"))
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                    }

                    Text("が")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                
                // 名前+チェックボックス
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                    ForEach(users.indices, id: \.self) { index in
                        HStack {
                            Button {
                                users[index].isPay.toggle()
                            } label: {
                                if users[index].isPay {
                                    Image(systemName: "checkmark.square.fill")
                                        .foregroundColor(Color("main"))
                                } else {
                                    Image(systemName: "square")
                                        .foregroundColor(Color("back"))
                                }
                            }
                            .fontWeight(.bold)
                            .font(.title)
                            Text(users[index].userName)
                        }
                        .padding()
                    }
                }
                
                //何代を払ったか
                HStack {
                    Text("の")
                        .padding(5)
                        .font(.headline)
                        .fontWeight(.semibold)

                    TextField("タクシー代", text: $priceTitle)
                        .padding(15)
                        .background(Color("background"))
                        .frame(width: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)

                    Text("を払って、")
                        .padding()
                        .font(.headline)
                        .fontWeight(.semibold)

                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0) {
//                   //いくらかかったか
                    Text("¥")
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)  // 必要に応じて調整
                        .background(Color("back"))
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                    
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                    TextField("4800", value: $paymentPrice, formatter: NumberFormatter())
                        .padding(.vertical, 15)
                        .padding(.leading, 15)
                        .background(Color("background"))
                        .frame(width: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                    
                    Text("かかった。")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()


                    
                }
                .padding()
                
                //登録ボタン
                Button {
                    let newBilling = Billing(
                        userId: userId,
                        groupId: groupId,
                        paymentPrice: paymentPrice,
                        priceTitle: priceTitle
                    )
                        billingGroupBy.billingByGroup.append(newBilling)
                    priceTitle = ""
                    paymentPrice = 0
                    print("ボタンが押されました")
                } label: {
                    Text("登録")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 350, height: 55)
                        .foregroundStyle(Color.white)
                        .background(Color("main"))
                        .cornerRadius(3)
                }
                .padding(.top, 40)
                //戻るボタン
                
                Button {
                    dismiss()
                } label: {
                    Text("戻る")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 350, height: 55)
                        .foregroundStyle(Color.black)
                        .background(Color("back"))
                        .cornerRadius(3)
                }
                .padding(.top, 10)
            }
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

//#Preview {
//    RegisterView(
//        groupId: UUID(),
//        billingGroupBy: [],
//        users: [User(userName: "たけ"), User(userName: "あおい"), User(userName: "かおる")]
//    )
//}
