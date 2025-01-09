//
// File: PlayerButton.swift
// Project: Twinmoji
// 
// Created by SCOTT CROWDER on 1/9/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

struct PlayerButton: View {
    
    var gameState: GameState
    var score: Int
    var color: Color
    var onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            Rectangle()
                .fill(color)
                .frame(minWidth: 60)
                .overlay(
                    Text(String(score))
                        .fixedSize()
                        .foregroundStyle(.white)
                        .font(.system(size: 48).bold())
                )
        }
        .disabled(gameState != .waiting)
    }
}

#Preview {
    PlayerButton(gameState: .waiting, score: 5, color: .blue) {
        
    }
}
