//
//  ChatSearchBar.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - ChatSearchBarViewModel
class ChatSearchBarViewModel: ObservableObject {
    @Published
    var isFocused: Bool = false
    
    @Published
    var text: String
    
    init(isFocused: Bool, text: String) {
        self.isFocused = isFocused
        self.text = text
    }
}
