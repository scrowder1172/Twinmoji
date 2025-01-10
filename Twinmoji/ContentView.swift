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
    var answerTime: Double
    @Binding var isGameActive: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            PlayerButton(gameState: gameState, score: player1Score, color: .blue, onSelect: selectPlayer1)
            
            ZStack {
                answerColor
                    .scaleEffect(x: answerScale, anchor: answerAnchor)
                
                if leftCard.isEmpty == false {
                    HStack {
                        CardView(card: leftCard, userCanAnswer: gameState != .waiting, onSelect: checkAnswer)
                        CardView(card: rightCard, userCanAnswer: gameState != .waiting, onSelect: checkAnswer)
                    }
                    .padding(.horizontal, 10)
                }
            }
            
            PlayerButton(gameState: gameState, score: player2Score, color: .red, onSelect: selectPlayer2)
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
        runTheClock()
    }
    
    func selectPlayer2() {
        guard gameState == .waiting else { return }
        answerColor = .red
        answerAnchor = .trailing
        gameState = .player2Answering
        runTheClock()
    }
    
    func timeOut() {
        if gameState == .player1Answering {
            player1Score -= 1
        } else if gameState == .player2Answering {
            player2Score -= 1
        }
        
        gameState = .waiting
    }
    
    func runTheClock() {
        answerScale = 1
        
        withAnimation(.linear(duration: answerTime)) {
            answerScale = 0
        } completion: {
            timeOut()
        }
    }
    
    func checkAnswer(_ string: String) {
        if string == currentEmoji[0] {
            if gameState == .player1Answering {
                player1Score += 1
            } else if gameState == .player2Answering {
                player2Score += 1
            }
            
            if player1Score == 5 || player2Score == 5 {
                // game over
            } else {
                createLevel()
            }
        } else {
            if gameState == .player1Answering {
                player1Score -= 1
            } else if gameState == .player2Answering {
                player2Score -= 1
            }
        }
        
        answerColor = .clear
        answerScale = 0
        gameState = .waiting
    }
}

#Preview {
    ContentView(itemCount: 9, answerTime: 1.0, isGameActive: .constant(true))
}
