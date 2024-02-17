//
//  SendButton.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - ChatSendButton
struct ChatSendButton: View {
    
    // MARK: - Properties
    @Environment(\.theme)
    var theme
    
    @State
    private var rotation: Double = 0
    
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(
            action: {
                
                withAnimation(.bouncy(duration: 0.8)) {
                    rotation += 360
                }
                
                action()
            },
            label: {
                
                arrowImage
                    .rotationEffect(.degrees(rotation))
                
            }
        )
        .disabled(!isEnabled)
    }
}
// MARK: - ChatSendButton + Arrow
private extension ChatSendButton {
    var arrowImage: some View {
        Image(systemName: "arrow.up")
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundStyle(.white.opacity(isEnabled ? 1 : 0.8))
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(
                Circle()
                    .fill()
                    .foregroundStyle(isEnabled ? theme.color.primary : Color.gray)
            )
    }
}
