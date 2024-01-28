//
//  ChatView.swift
//  ChatGPTChat
//
//  Created by Raj S on 26/01/24.
//

import SwiftUI

// MARK: - ChatView
struct ChatView: View {
    
    // MARK: - Property
    @State
    var viewModel: ChatViewModel

    @Environment(\.theme) 
    var theme
    
    var body: some View {
        NavigationView {
            VStack {
                
                if viewModel.messages.isEmpty {
                    ChatEmptyView()
                } else {
                    messageListView
                }
                
                bottomBarView
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .padding(.top, 8)
                
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(
                    placement: .principal,
                    content: {
                        navbarTitleView
                    }
                )
                
                if !viewModel.isSearchActive {
                    ToolbarItem(placement: .topBarTrailing) {
                        searchView
                    }
                }
                
            }
            
        }
        
    }
}

// MARK: - ChatView + Message List
private extension ChatView {
    
    var messageListView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.messages) { message in
                    
                    ChatMessageView(message: message, highLightString: viewModel.searchBarViewModel.text)
                        .observeSize { _ in
                            let oldId = viewModel.scrollToMessageId
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    viewModel.scrollToMessageId = oldId
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                    
                }
            }
        }
        .scrollPosition(
            id: $viewModel.scrollToMessageId,
            anchor: .bottom
        )
    }

}

// MARK: - ChatView + Bottom Bar
private extension ChatView {
    
    @ViewBuilder
    var bottomBarView: some View {
        if viewModel.isSearchActive {
            ChatSearchBottomBar(
                viewModel: viewModel.searchBottomInfoViewModel
            )
        } else {
            ChatMessageInputView(
                viewModel: viewModel.messageInputViewModel
            )
        }
    }
    
}

// MARK: - ChatView + TitleView
private extension ChatView {
    
    @ViewBuilder
    var navbarTitleView: some View {
        if viewModel.isSearchActive {
            searchBar
        } else {
            Text("Chat")
                .foregroundStyle(theme.color.primary)
        }
    }
    
    var searchBar: some View {
        HStack(spacing: 0) {
            ChatSearchBar(viewModel: viewModel.searchBarViewModel)
                
            cancelButton
        }
        .padding(.vertical, 4)
    }
    
    var cancelButton: some View {
        Button(
            action: {
                viewModel.turnOffSearch()
            },
            label: {
                Text("Cancel")
                    .foregroundStyle(theme.color.primary)
            }
        )
    }
    
}

// MARK: - ChatView + SearchView
private extension ChatView {
    var searchView: some View {
        Button(
            action: {
                viewModel.turnOnSearch()
            },
            label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(theme.color.primary.opacity(0.8))
            }
        )
    }
}

// MARK: - ChatView + Preview
#Preview {
    ChatView(
        viewModel: .init(repository: LocalDataChatRepository())
    )
}




