//
//  MessageResponseAnimator.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation

// MARK: - MessageResponseAnimator
class MessageResponseAnimator {
    
    private var timer: Timer!
    private let fullMessage: String
    private var messageCurrentIndex: Int = 0
    
    var isActive: Bool {
       return timer?.isValid ?? false
    }
    
    init(fullMessage: String) {
        self.fullMessage = fullMessage
    }
    
    func start(
        didMessageUpdate: @escaping (String) -> Void,
        didComplete: @escaping () -> Void
    ) {
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 0.025,
            repeats: true
        ) { [weak self]  timer in
            guard let self else { return }
            
            guard messageCurrentIndex < fullMessage.count else {
                timer.invalidate()
                didComplete()
                return
            }
            
            let endIndex = fullMessage.index(fullMessage.startIndex, offsetBy: messageCurrentIndex)
            let range = fullMessage.startIndex...endIndex
            messageCurrentIndex += 1
            
            didMessageUpdate(String(fullMessage[range]))
        }
    }
}
