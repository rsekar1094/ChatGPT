//
//  ChatSearchBar.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - ChatSearchBar
struct ChatSearchBar: View {
    
    // MARK: - Properties
    @Environment(\.theme)
    var theme
    
    @ObservedObject
    var viewModel: ChatSearchBarViewModel
    
    let focusedState: FocusState<Bool>.Binding
    
    var body: some View {
        HStack(spacing: 0) {
            searchView
                .padding(.leading, 16)
                .padding(.trailing, 8)
            
            TextField("Search", text: $viewModel.text)
                .focused(focusedState)
               
            deleteView
                .padding(.horizontal, 8)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - ChatSearchBar + Actions
private extension ChatSearchBar {
    
    var searchView: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundStyle(theme.color.primary.opacity(0.8))
    }
    
    var deleteView: some View {
        Button(
            action: {
                viewModel.text = ""
            },
            label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.black.opacity(0.5))
            }
        )
    }
}
