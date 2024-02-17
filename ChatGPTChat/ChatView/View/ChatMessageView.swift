//
//  ChatMessageView.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - ChatMessageView
struct ChatMessageView: View {
    
    // MARK: - Properties
    let message: Message
    
    let highLightString: String
    
    @Environment(\.theme) 
    var theme
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
           
            userImageView
            
            VStack(alignment: .leading, spacing: 4) {
               userTitleView
                
                contentView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
    
}

// MARK: - ChatMessageView + ContentView
private extension ChatMessageView {
    
    @ViewBuilder
    var contentView: some View {
        switch messageContent {
        case .loading:
            CircularLoader()
                .frame(width: 20, height: 20)
        case .error(let message):
            Text(message)
                .foregroundStyle(theme.color.error)
                .frame(maxWidth: .infinity, alignment: .leading)
        case .data(let content):
            dataView(for: content)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var messageContent: MessageContent {
        switch message {
        case .user(let data):
            return data.content
        case .agent(let data):
            return data.content
        }
    }
}

// MARK: - ChatMessageView + UserImage
private extension ChatMessageView {
    
    @ViewBuilder
    func dataView(for content: String) -> some View {
        if highLightString.isEmpty {
            Text(content)
        } else {
            Text(highlight(content,with: highLightString))
        }
    }
    
    func highlight(_ string: String, with boldPart: String) -> AttributedString {
        let attributedString = NSMutableAttributedString(string: string)
    
        string.lowercased().ranges(of: boldPart.lowercased()).forEach { range in
            let nsRange = NSRange(range, in: string)

            attributedString.addAttributes([
                .foregroundColor: UIColor.white,
                .backgroundColor: UIColor(theme.color.primary)
            ], range: nsRange)
        }
        
        return AttributedString(attributedString)
    }
}

// MARK: - ChatMessageView + UserImage
private extension ChatMessageView {
    
    var userImageView: some View {
        Image(userImageName)
            .resizable()
            .scaledToFill()
            .frame(width: 25,height: 25)
            .clipShape(Circle())
    }
    
    var userImageName: String {
        switch message {
        case .user:
            return "user"
        case .agent:
            return "agent"
        }
    }
    
}

// MARK: - ChatMessageView + UserTitle
private extension ChatMessageView {
    
    var userTitleView: some View {
        Text(userDisplayName)
            .font(theme.font.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var userDisplayName: String {
        switch message {
        case .user:
            return "User"
        case .agent:
            return "Bot"
        }
    }
    
}
