//
//  Sample.swift
//  WarikanApp
//
//  Created by 大竹駿 on 2025/07/31.
//

import SwiftUI

struct Sample: View {
    let names = ["take", "akihiro", "satoru", "takeda", "kanegon", "yosihide", "takehusa", "kaoru", "kaori", "takeda"]
    
    var body: some View {
        VStack(alignment: .leading) {
            FlowLayout(spacing: 8, lineSpacing: 8) {
                ForEach(names, id: \.self) {name in
                    HStack(spacing: 4) {
                        Text(name)
                            .padding(8)
                            .background(Color.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    Sample()
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    var lineSpacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var lineHeight: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if width + size.width > maxWidth {
                width = 0
                height += lineHeight + lineSpacing
                lineHeight = 0
            }
            
            width += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
        
        return CGSize(width: maxWidth, height: height + lineHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lineHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if x + size.width > bounds.width {
                x = 0
                y += lineHeight + lineSpacing
                lineHeight = 0
            }
            
            subview.place(
                at: CGPoint(x: bounds.minX + x, y: bounds.minY + y),
                proposal: ProposedViewSize(width: size.width, height: size.height)
            )
            
            x += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }
    
}
