//
//  ContentView.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("main")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("""
                        もう、誰が誰に
                        何円返せばいいんだっけ
                        で迷わない。
                        """)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                    
                    Text("""
                        友達と旅行で、レンタカーや高速道路代など、
                        お金の貸し借りをした時、最終的に誰が誰に何
                        円返すべきか混乱することはありませんか？
                        Walicanは、旅先での割り勘計算のわずらわし
                        さをシンプルに解決してくれる無料のサービス
                        です。
                        """)
                    .font(.
                          headline)
                    .padding(20)
                    
                    Button {
                        print("ボタンが押されました")
                    } label: {
                        Text("はじめる")
                            .bold()
                            .padding(.horizontal, 140)
                            .padding(.vertical, 12)
                            .foregroundStyle(Color("main"))
                            .background(Color.white)
                            .cornerRadius(25)
                    }
                    Spacer()
                    
                }
                .foregroundStyle(Color.white)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Walican")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
