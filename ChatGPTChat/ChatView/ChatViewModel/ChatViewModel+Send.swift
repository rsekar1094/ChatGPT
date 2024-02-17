//
//  ChatViewModel+Send.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation
import SwiftUI

// MARK: - ChatViewModel + send
extension ChatViewModel {
    
    func send() {
        let typedMessage = messageInputViewModel.message
        guard !typedMessage.isEmpty else { return }
        
        self.messageInputViewModel.message = ""
        
        messages.append(.user(.init(content: .data(typedMessage))))
        
        let loadingMessage = MessageData(content: .loading)
        messages.append(.agent(loadingMessage))
       
        withAnimation {
            scrollToMessageId = loadingMessage.id
        }
        
        messageInputViewModel.isSendEnabled = false
        
        Task {
            do {
                let response = try await self.repository.send(message: typedMessage)
                 
                DispatchQueue.main.async {
                    self.addAgentResponse(response, messageId: loadingMessage.id)
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    self.updateAgentsError(error, messageId: loadingMessage.id)
                }
            }
        }
    }
    
    func rescrollToLastMessageIdIfAnimatorOn() {
        guard self.currentMessageAnimator?.isActive ?? false else {
            return
        }
        
        rescrollToLastMessageId()
    }
}

// MARK: - ChatViewModel + Agent
private extension ChatViewModel {
    func addAgentResponse(_ response: String, messageId: String) {
        self.currentMessageAnimator = .init(fullMessage: response)
        self.currentMessageAnimator?.start(
            didMessageUpdate: { [weak self] message in
                guard let self else { return }
                
                let newMessage = MessageData(id: messageId,content: .data(message))
                self.messages[messages.count - 1] = .agent(newMessage)
            
            },
            didComplete: { [weak self] in
                guard let self else { return }
                self.messageInputViewModel.isSendEnabled = true
    
                self.rescrollToLastMessageId()
            }
        )
       
        withAnimation {
            self.scrollToMessageId = messageId
        }
    }
    
    func rescrollToLastMessageId() {
        self.scrollToMessageId = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.scrollToMessageId = self.messages.last?.id
            }
        }
    }
}

private extension ChatViewModel {
    func updateAgentsError(_ error: Error, messageId: String) {
        messages[messages.count - 1] = .agent(.init(id: messageId, content: .error(error.localizedDescription)))
        messageInputViewModel.isSendEnabled = true
    }
}
