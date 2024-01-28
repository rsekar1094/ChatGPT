//
//  ChatViewModel+Message.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation

// MARK: - Message
enum Message: Identifiable {
    case user(MessageData)
    case agent(MessageData)
    
    var id: String {
        switch self {
        case .agent(let data):
            return data.id
        case .user(let data):
            return data.id
        }
    }
    
    var isAgent: Bool {
        switch self {
        case .agent:
            return true
        default:
            return false
        }
    }
}

// MARK: - MessageData
struct MessageData: Identifiable {
    let id: String
    let content: MessageContent
    
    init(id: String = UUID().uuidString, content: MessageContent) {
        self.id = id
        self.content = content
    }
}

// MARK: - MessageContent
enum MessageContent {
    case loading
    case data(String)
    case error(String)
}
