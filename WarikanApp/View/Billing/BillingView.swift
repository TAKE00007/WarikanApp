//
//  BillingView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/09/22.
//

import SwiftUI

enum TopTab: String, Identifiable, Hashable, CaseIterable {
    case kashikari = "貸し借り"
    case shishutu = "支出"
    
    var id: String { rawValue }
}

struct TopPillTabs: View {
    @Binding var selection: TopTab
    var tabs: [TopTab] = TopTab.allCases
    
    @Namespace private var ns
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ForEach(tabs) { tab in
                    Button {
                        selection = tab
                    } label: {
                        Text(tab.rawValue)
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(selection == tab ? Color.white : Color.primary)
                    .background(
                        ZStack {
                            if selection == tab {
                                Capsule()
                                    .fill(Color(.blue))
                                    .matchedGeometryEffect(id: "TAB", in: ns)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                }
            }
            .background(Color(.systemGray6))
            .clipShape(Capsule())
            .padding(6)
        }
    }
}

struct BillingView: View {
    @State private var selection: TopTab = .kashikari
    let users: [User]
    let billings: [Billing]
    let billingParticipants: [BillingParticipant]
    
    var shishutuList: [(String, Int)] {
        shishutu(users: users, billings: billings, billingParticipants: billingParticipants)
    }
    
    var kashikariList: [(String, Int)] {
        kashikari(users: users, billings: billings, billingParticipants: billingParticipants)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            TopPillTabs(selection: $selection)
                .padding(.horizontal, 20)
            
            VStack(spacing: 0) {
                switch selection {
                case .kashikari:
                    KashikariListView(kashikariList: kashikariList)
                case .shishutu:
                    ShishutuListView(shishutuList: shishutuList)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Walica")
    }
    
    private func shishutu(users: [User], billings: [Billing], billingParticipants: [BillingParticipant]) -> [(String, Int)] {
        
        // userId -> 合計負担額
        var amountByUser: [UUID: Int] = [:]
        
        for billing in billings {
            // 対象の明細に紐づく参加者
            let participants = billingParticipants.filter { $0.billingId == billing.id }
            // 割り勘対象者のみ
            let sharers = participants.filter { $0.isShare }
            let count = sharers.count
            
            // 余りは切り捨て
            let baseShare = billing.paymentPrice / count
            
            for participant in sharers {
                amountByUser[participant.userId, default: 0] += baseShare
            }
        }
        
        // (userName, amount) に変換。名前不明は "Unknown" とする
        let results: [(String, Int)] = amountByUser.map { (userId, amount) in
            let name = users
                .first { $0.id == userId }
                .map { $0.userName } ?? "Unknown"
            return (name, amount)
        }
        
        return results
    }
    
    private func kashikari(users: [User], billings: [Billing], billingParticipants: [BillingParticipant]) -> [(String, Int)] {
        
        // userId -> 合計負担額
        var amountByUser: [UUID: Int] = [:]
        
        for billing in billings {
            // 対象の明細に紐づく参加者
            let participants = billingParticipants.filter { $0.billingId == billing.id }
            // 割り勘対象者のみ
            let sharers = participants.filter { $0.isShare }
            let count = sharers.count
            
            // 余りは切り捨て
            let baseShare = billing.paymentPrice / count
            
            for participant in sharers {
                if participant.userId == billing.userId {
                    amountByUser[participant.userId, default: 0] += billing.paymentPrice - baseShare
                } else {
                    amountByUser[participant.userId, default: 0] -= baseShare
                }
            }
        }
        
        // (userName, amount) に変換。名前不明は "Unknown" とする
        let results: [(String, Int)] = amountByUser.map { (userId, amount) in
            let name = users
                .first { $0.id == userId }
                .map { $0.userName } ?? "Unknown"
            return (name, amount)
        }
        
        return results
    }
}

//#Preview("BillingView – Light") {
//    NavigationStack { BillingView() }
//}
//
//// SizeThatFits で最小レイアウトだけを描画（軽量）
//#Preview("TopPillTabs – 貸し借り (SizeThatFits)", traits: .sizeThatFitsLayout) {
//    TopPillTabsPreview(initial: .kashikari)
//        .padding(.horizontal, 20)
//}
//
//// Dark + SizeThatFits を同時指定（ダークはモディファイアで指定）
//#Preview("TopPillTabs – 支出 (Dark, SizeThatFits)", traits: .sizeThatFitsLayout) {
//    TopPillTabsPreview(initial: .shishutu)
//        .padding(.horizontal, 20)
//        .preferredColorScheme(.dark)
//}

// Bindingを持たせるためのラッパー（プレビュー時はアニメーション無効化で軽量化）
private struct TopPillTabsPreview: View {
    @State var selection: TopTab
    init(initial: TopTab) { _selection = State(initialValue: initial) }
    var body: some View {
        TopPillTabs(selection: $selection)
            // プレビューではアニメーションを切って安定・軽量化
            .transaction { $0.animation = nil }
    }
}
