//
//  Message+Array.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation

extension Array where Element == Message {
    
    func filter(with text: String) -> [Message] {
        filter { $0.contains(text: text)  }
    }
    
}

private extension Message {
    func contains(text: String) -> Bool {
        switch self {
        case .user(let data):
            data.content.contains(text: text)
        case .agent(let data):
            data.content.contains(text: text)
        }
    }
}

private extension MessageContent {
    func contains(text: String) -> Bool {
        switch self {
        case .loading:
            return false
        case .data(let value):
            return value.lowercased().contains(text.lowercased())
        case .error:
            return false
        }
    }
}
