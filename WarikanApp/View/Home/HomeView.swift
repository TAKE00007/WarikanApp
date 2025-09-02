//
//  Home.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/08/02.
//

import SwiftUI

struct HomeView: View {
    @Binding var group: Group
    @State var users: [User] = []
    @State var billings: [Billing] = []
    @State var billingParticipants: [BillingParticipant] = []
    
    var warikanResults: [PaymentResult] {
        let calc = WarikanCalculate(
            billings: billings,
            users: users
        )
        return calc.warikanCalculate(
            billings: billings,
            users: users,
            billingParticipants: billingParticipants
        )
    }
    
    var body: some View {
        NavigationStack {
            HeaderView(group: $group, users: $users)
            VStack {
                NavigationLink(destination: RegisterView(
                    groupId: group.id,
                    users: $users,
                    billings: $billings,
                    billingParticipants: $billingParticipants)
                ){
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
                
                ScrollView {
                    //支払い記録を表示
                    ForEach($billings) { $billing in
                        BillingCard(billing: $billing, billings: $billings, billingParticipants: $billingParticipants, users: users)
                    }
                    
                    VStack {
                        HStack {
                            Text("精算方法")
                                .bold()
                                .padding()
                            Spacer()
                            Text("共有用にコピー")
                                .padding()
                        }
                        // 支払うべき人一覧を表示
                        ForEach(warikanResults) { result in
                            payToCard(sendUserName: result.from.userName, giveUserName: result.to.userName, amount: result.amount)
                        }
                    }
                    .padding(.top, 100)
                }
                
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
            .navigationBarBackButtonHidden(true)
        }
        .task {
            await loadUsers()
        }
    }
    
    private func loadUsers() async {
        let repo = UserRepository()
        do {
            let fetched = try await repo.fetchUsers(byGroupId: group.id)
            users = fetched
        } catch {
            print("ユーザー取得失敗: \(error.localizedDescription)")
        }
    }
    private func loadBillings() async {
        let repo = BillingRepository()
        do {
            let fetched = try await repo.fetchBillings(byGroupId: group.id)
            billings = fetched
        } catch {
            print("明細取得失敗: \(error.localizedDescription)")
        }
    }
    private func loadBillingParticipants() async {
        let repo = BillingParticipantRepository()
        do {
            let fetched = try await repo.fetchBillingParticipants(byGroupId: group.id)
            billingParticipants = fetched
        } catch {
            print("個人ごとの明細取得失敗: \(error.localizedDescription)")
        }
    }
    
}

//#Preview {
//    HomeView(
//        group: Group(groupName: "北海道旅行")
//    )
//}

extension DateFormatter {
    static let monthDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "MM/dd"
        return formatter
    } ()
}
