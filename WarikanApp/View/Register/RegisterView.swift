//
//  Register.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/17.
//

import SwiftUI
@available(iOS 16.0, *)

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    let groupId: UUID

    @State private var selectedIndex = 0
    @State private var priceTitle = ""
    @State private var paymentPrice = 0
    @State private var userId: UUID?
    @State private var errorMessage: String?
    @Binding var users: [User]
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
                    TextField("4800", value: $paymentPrice, formatter: numberFormatter)
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
                    guard let userId else {
                        errorMessage = "ユーザーが選択されていません"
                        return
                    }
                    
                    let newBilling = Billing(
                        userId: userId,
                        groupId: groupId,
                        paymentPrice: paymentPrice,
                        priceTitle: priceTitle
                    )
                    var newBillingParticipants: [BillingParticipant] = []
                    
                    for user in users {
                        let newBillingParticipant = BillingParticipant(
                            billingId: newBilling.id,
                            userId: user.id,
                            groupId: groupId,
                            isShare: user.isPay
                        )
                        newBillingParticipants.append(newBillingParticipant)
                    }
                    
                    Task {
                        do {
                            let service = BillingService()
                            try await service.createBillingWithParticipants(
                                billing: newBilling,
                                billingParticipants: newBillingParticipants
                            )
                        } catch {
                            print("明細登録失敗")
                        }
                        
                        billings.append(newBilling)
                        billingParticipants.append(contentsOf: newBillingParticipants)
                        priceTitle = ""
                        paymentPrice = 0
                        dismiss()
                    }
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
                .alert(isPresented: .constant(errorMessage != nil)) {
                    Alert(
                        title: Text("エラー"),
                        message: Text(errorMessage ?? ""),
                        dismissButton: .default(Text("OK")) {
                            errorMessage = nil
                        }
                    )
                }
                
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
                //usersが渡された後に初期値を代入
                if !users.isEmpty {
                    userId = users[selectedIndex].id
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    Text("Walican")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .toolbarBackground(Color("main"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

//#Preview {
//    RegisterView(
//        groupId: UUID(),
//        billingGroupBy: [],
//        users: [User(userName: "たけ"), User(userName: "あおい"), User(userName: "かおる")]
//    )
//}
