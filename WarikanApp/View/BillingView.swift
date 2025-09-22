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
            Capsule()
                .fill(Color(.systemGray6))
            HStack(spacing: 0) {
                ForEach(tabs) { tab in
                    Button {
                        selection = tab
                    } label: {
                        Text(tab.rawValue)
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .contentShape(Rectangle())
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
            .clipShape(Capsule())
            .padding(6)
        }
    }
}

struct BillingView: View {
    @State private var selection: TopTab = .kashikari
    
    var body: some View {
        VStack(spacing: 16) {
            TopPillTabs(selection: $selection)
                .padding(.horizontal, 20)
            
            VStack(spacing: 0) {
                switch selection {
                case .kashikari:
                    KashikariListView()
                case .shishutu:
                    ShishutuListView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Walica")
    }
}

struct KashikariListView: View {
    var body: some View {
        Text("kashikari")
    }
}

struct ShishutuListView: View {
    var body: some View {
        Text("shishutu")
    }
}
