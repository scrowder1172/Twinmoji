//
// File: ContentView.swift
// Project: Twinmoji
// 
// Created by SCOTT CROWDER on 1/9/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

enum GameState {
    case waiting
    case player1Answering
    case player2Answering
}

struct ContentView: View {
    
    let allEmoji = Array("😎🥹🥰😔😂😳🧐🙂😇😅😆😙😬🙃😍🥸😣😶🙄🤨😩😉🥲😋😛🤓😏😭😯😵😐😘😢😠").map(String.init)
    
    @State private var currentEmoji: [String] = []
    
    @State private var leftCard: [String] = []
    @State private var rightCard: [String] = []
    
    @State private var gameState = GameState.waiting
    
    @State private var player1Score: Int = 0
    @State private var player2Score: Int = 0
    
    @State private var answerColor: Color = .clear
    @State private var answerScale: Double = 1.0
    @State private var answerAnchor = UnitPoint.center
    
    var itemCount: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if leftCard.isEmpty == false {
                    HStack {
                        CardView(card: leftCard)
                        CardView(card: rightCard)
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.9))
        .persistentSystemOverlays(.hidden)
        .onAppear(perform: createLevel)
    }
    
    func createLevel() {
        currentEmoji = allEmoji.shuffled()
        
        withAnimation(.spring(duration: 0.75)) {
            leftCard = Array(currentEmoji[0..<itemCount]).shuffled()
            rightCard = Array(currentEmoji[itemCount + 1..<itemCount + itemCount] + [currentEmoji[0]]).shuffled()
            
        }
    }
    
    func selectPlayer1() {
        guard gameState == .waiting else { return }
        answerColor = .blue
        answerAnchor = .leading
        gameState = .player1Answering
    }
    
    func selectPlayer2() {
        guard gameState == .waiting else { return }
        answerColor = .red
        answerAnchor = .trailing
        gameState = .player2Answering
    }
}

#Preview {
    ContentView(itemCount: 9)
}
