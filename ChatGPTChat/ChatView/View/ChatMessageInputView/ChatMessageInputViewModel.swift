//
//  ChatMessageInputViewModel.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation
import Observation

// MARK: - ChatMessageInputViewModel
@Observable
class ChatMessageInputViewModel {
    var message: String
    var isSendEnabled: Bool
    let send: () -> Void
    
    init(message: String, isSendEnabled: Bool, send: @escaping () -> Void) {
        self.message = message
        self.isSendEnabled = isSendEnabled
        self.send = send
    }
}
