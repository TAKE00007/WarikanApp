//
//  UpdateRegisterView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/02.
//

import SwiftUI

struct UpdateRegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedIndex = 0
    @State private var userId: UUID?
    @State private var paymentTitle = ""
    @State private var paymentText = ""
    let users: [User]
    @Binding var billing: Billing
    @Binding var billings: [Billing]
    @Binding var billingParticipants: [BillingParticipant]
    
    
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
                                .foregroundColor(Color.black)
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
                    ForEach(users) { user in
                        UserRow(user: user)
                    }
                }
                
                //何代を払ったか
                HStack {
                    Text("の")
                        .padding(5)
                        .font(.headline)
                        .fontWeight(.semibold)

                    TextField(paymentTitle, text: $paymentTitle)
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
                    TextField(paymentText, text: $paymentText)
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
                    for billingParticipant in billingParticipants {
                        if billingParticipant.billingId == billing.id {
                            billingParticipant.isShare = users.first { $0.id == billingParticipant.userId }?.isPay ?? true
                        }
                    }
                    billing.priceTitle = paymentTitle
                    billing.paymentPrice = Int(paymentText) ?? billing.paymentPrice
                    billing.userId = userId!
                    billing.createdAt = Date()
                    print("ボタンが押されました")
                    dismiss()
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
            .onAppear {
                paymentTitle = billing.priceTitle
                paymentText = String(billing.paymentPrice)
                
                if let index = users.firstIndex(where: { $0.id == billing.userId }) {
                    selectedIndex = index
                    userId = users[index].id
                }
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
//    UpdateRegisterView()
//}
