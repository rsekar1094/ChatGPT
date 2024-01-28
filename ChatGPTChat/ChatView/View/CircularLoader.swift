//
//  CircularLoader.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - CircularLoader
struct CircularLoader: View {
    
    // MARK: - Properties
    @Environment(\.theme)
    var theme
    
    @State
    private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .opacity(0.3)
                .foregroundColor(theme.color.primary)
            
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .foregroundColor(theme.color.primary)
                .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear() {
                    self.isAnimating = true
                }
        }
    }
}
