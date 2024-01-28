//
//  ChatSearchBottomBarViewModel.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation

// MARK: - ChatSearchBottomBarViewModel
class ChatSearchBottomBarViewModel: ObservableObject {
    
    @Published
    var currentSearchIndex: Int = 0
    
    var matchFoundIds: [String] = []
    let upAction: () -> Void
    let downAction: () -> Void
    
    init(
        upAction: @escaping () -> Void,
        downAction: @escaping () -> Void
    ) {
        self.upAction = upAction
        self.downAction = downAction
    }
}

// MARK: - ChatSearchBottomBarViewModel + total
extension ChatSearchBottomBarViewModel {
    var totalSearchFound: Int { matchFoundIds.count }
}

// MARK: - ChatSearchBottomBarViewModel + info
extension ChatSearchBottomBarViewModel {
    var info: String {
        guard totalSearchFound > 0 else { return "" }
        return "\(currentSearchIndex + 1) of \(totalSearchFound) matches"
    }
}

// MARK: - ChatSearchBottomBarViewModel + Enabled
extension ChatSearchBottomBarViewModel {
    var isUpEnabled: Bool {
        guard totalSearchFound > 0 else { return false }
        
        return currentSearchIndex < totalSearchFound - 1
    }
    
    var isDownEnabled: Bool {
        guard totalSearchFound > 0 else { return false }
        
        return currentSearchIndex > 0
    }
}
