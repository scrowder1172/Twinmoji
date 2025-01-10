//
// File: MenuView.swift
// Project: Twinmoji
// 
// Created by SCOTT CROWDER on 1/9/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

struct MenuView: View {
    
    @State private var timeOut: Double = 1.0
    @State private var items: Int = 9
    @State private var isGameActive: Bool = false
    
    var body: some View {
        if isGameActive {
            ContentView(itemCount: items, answerTime: timeOut, isGameActive: $isGameActive)
        } else {
            VStack(spacing: 10) {
                Text("Twinmoji")
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                
                Text("Answer Time")
                    .font(.headline)
                
                Picker("Timeout", selection: $timeOut) {
                    Text("Slow").tag(2.0)
                    Text("Medium").tag(1.0)
                    Text("Fast").tag(0.5)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                Text("Difficulty")
                    .font(.headline)
                
                Picker("Difficulty", selection: $items) {
                    Text("Easy").tag(9)
                    Text("Hard").tag(12)
                }
                .pickerStyle(.segmented)
                
                Button("Start Game") {
                    isGameActive = true
                }
                .buttonStyle(.borderedProminent)
                
                
            }
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color(white: 0.9))
        }
    }
}

#Preview {
    MenuView()
}
