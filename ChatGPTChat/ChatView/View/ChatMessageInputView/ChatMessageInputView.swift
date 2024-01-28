//
//  MessageInputView.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - ChatMessageInputView
struct ChatMessageInputView: View {
    
    // MARK: - Properties
    @State
    var isAddButtonExpand: Bool = false
    
    @Environment(\.theme)
    var theme
    
    @State
    var viewModel: ChatMessageInputViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            if isAddButtonExpand {
                
                mediaOptionView(with: "camera")
                
                mediaOptionView(with: "photo")
                
                mediaOptionView(with: "folder")
                
            } else {
                
                addMediaView
                
            }
            
            messageTextField
            
            ChatSendButton(isEnabled: viewModel.isSendEnabled) {
                viewModel.send()
            }
        }
        .animation(
            .spring(.bouncy),
            value: isAddButtonExpand
        )
    }
}

// MARK: - ChatMessageInputView + TextField
private extension ChatMessageInputView {
    
    var messageTextField: some View {
        TextField("Message", text: $viewModel.message)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .overlay {
                RoundedRectangle(
                    cornerSize: .init(width: 16, height: 16)
                )
                .stroke()
                .foregroundStyle(.gray.opacity(0.5))
            }
    }
    
}

// MARK: - ChatMessageInputView + MediaView
private extension ChatMessageInputView {
    
    var addMediaView: some View {
        Button(
            action: {
                isAddButtonExpand.toggle()
            },
            label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(theme.color.primary.opacity(0.6))
                    .frame(width: 32, height: 32)
                    .background(
                        Circle()
                            .fill()
                            .foregroundStyle(theme.color.secondary)
                    )
            }
        )
    }
    
    func mediaOptionView(with imageName: String) -> some View {
        Button(
            action: {
                isAddButtonExpand.toggle()
            },
            label: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(theme.color.primary.opacity(0.8))
            }
        )
    }
    
}
