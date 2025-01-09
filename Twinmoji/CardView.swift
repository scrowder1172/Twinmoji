//
// File: CardView.swift
// Project: Twinmoji
// 
// Created by SCOTT CROWDER on 1/9/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

struct CardView: View {
    
    var card: [String]
    
    var rows: Int {
        if card.count == 12 {
            4
        } else {
            3
        }
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<rows, id: \.self) { i in
                GridRow {
                    ForEach(0..<3) { j in
                        let text = card[i * 3 + j]
                        
                        Button(text) {
                            // emoji was selected
                        }
                    }
                }
            }
        }
        .font(.system(size: 64))
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 20))
        .fixedSize()
        .shadow(radius: 10)
    }
}

#Preview {
    CardView(card: ["1", "2", "3", "4", "5", "6", "7", "8", "9"])
}
