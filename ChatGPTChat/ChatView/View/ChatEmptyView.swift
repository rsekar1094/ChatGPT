//
//  ChatEmptyView.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - ChatEmptyView
struct ChatEmptyView: View {
    
    // MARK: - Property
    @Environment(\.theme)
    var theme
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image("user")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(lineWidth: 4)
                        .foregroundColor(theme.color.primary)
                }
            
            Text(messages.randomElement() ?? messages[0])
                .multilineTextAlignment(.center)
                .font(theme.font.body)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                        
            Spacer()
        }
    }
}

// MARK: - ChatEmptyView + Message
private extension ChatEmptyView {
    
    var messages: [String] {
        return [
            "Just warming up my circuits... Talk to me, I promise I won't byte!",
            "I'm currently reading the entire internet to prepare for our chat. Might take a while... Or, you could just start typing!",
            "Practicing my best responses in the mirror. Okay, I'm ready – what's on your mind?",
            "I'm busy sorting 0s from 1s, but I'm all ears for you. What's up?",
            "I've been waiting for this moment! What would you like to chat about?",
            "Just doing some digital yoga to stay flexible for our chat. What shall we talk about today?",
            "Loading witty responses... Ready to outwit me in a chat battle?",
            "In a deep philosophical debate with myself. Care to join in?",
            "I'm here, ready to solve mysteries, answer questions, or chat about the weather on Mars!",
            "If you hear typing sounds, that's just me practicing for our chat. Your turn!"
        ]
    }
    
}

// MARK: - ChatEmptyView + Preview
#Preview {
    ChatEmptyView()
}
