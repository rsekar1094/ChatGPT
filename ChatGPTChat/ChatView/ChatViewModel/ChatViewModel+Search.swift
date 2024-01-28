//
//  ChatViewModel+Search.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

extension ChatViewModel {
    
    func addSearchObservers() {
        searchBarViewModel.$text
            .dropFirst()
            .removeDuplicates()
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                
                guard !text.isEmpty else {
                    self.searchBottomInfoViewModel.matchFoundIds = []
                    self.searchBottomInfoViewModel.currentSearchIndex = 0
                    return
                }
                
                let matchedIds = Array(self.messages.filter(with: text).map { $0.id }.reversed())
                self.searchBottomInfoViewModel.matchFoundIds = matchedIds
                self.searchBottomInfoViewModel.currentSearchIndex = 0
                
                let messages = self.messages
                self.messages = messages
            }
            .store(in: &subscribers)
        
        searchBottomInfoViewModel.$currentSearchIndex
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] index in
                guard let self else { return }
                
                let matchFoundIds = self.searchBottomInfoViewModel.matchFoundIds
                
                guard !matchFoundIds.isEmpty, matchFoundIds.count > index else {
                    return
                }
                
                withAnimation {
                    self.scrollToMessageId = matchFoundIds[index]
                }
            }
            .store(in: &subscribers)
    }
    
}
