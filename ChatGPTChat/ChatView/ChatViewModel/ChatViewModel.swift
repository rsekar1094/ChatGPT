//
//  ChatViewModel.swift
//  ChatGPTChat
//
//  Created by Raj S on 26/01/24.
//

import Foundation
import Observation
import SwiftUI
import Combine

// MARK: - ChatViewModel
@Observable
class ChatViewModel {
    
    // MARK: - Property
    var messages: [Message] = []
    var scrollToMessageId: String?
    var isSearchActive: Bool = false
    
    let searchBarViewModel: ChatSearchBarViewModel = ChatSearchBarViewModel(isFocused: false, text: "")
    private(set) var searchBottomInfoViewModel: ChatSearchBottomBarViewModel!
    private(set) var messageInputViewModel: ChatMessageInputViewModel!

    let repository: ChatRepository
    
    @ObservationIgnored
    var subscribers: Set<AnyCancellable> = .init()

    @ObservationIgnored
    var currentMessageAnimator: MessageResponseAnimator?
    
    // MARK: - Initializer
    init(repository: ChatRepository) {
        self.repository = repository
        
        self.searchBottomInfoViewModel = .init(
            upAction: { [weak self] in
                guard let self else { return }
                self.upArrowAction()
            },
            downAction: { [weak self] in
                guard let self else { return }
                self.downArrowAction()
            }
        )
        
        self.messageInputViewModel = .init(
            message: "",
            isSendEnabled: true,
            send: { [weak self] in
                guard let self else { return }
                self.send()
            }
        )
        
        addSearchObservers()
    }
    
}

// MARK: - ChatViewModel + Search
extension ChatViewModel {
    
    func turnOnSearch() {
        searchBarViewModel.text = ""
        isSearchActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.searchBarViewModel.isFocused = true
        }
    }
    
    func turnOffSearch() {
        searchBarViewModel.text = ""
        isSearchActive = false
    }
    
    func upArrowAction() {
        searchBottomInfoViewModel.currentSearchIndex += 1
    }
    
    func downArrowAction() {
        searchBottomInfoViewModel.currentSearchIndex -= 1
    }
    
}
