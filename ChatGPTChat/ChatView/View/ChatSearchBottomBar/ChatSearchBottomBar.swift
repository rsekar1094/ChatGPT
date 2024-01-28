//
//  ChatSearchBottomBar.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

// MARK: - ChatSearchBottomBar
struct ChatSearchBottomBar: View {
    
    // MARK: - Properties
    @StateObject
    var viewModel: ChatSearchBottomBarViewModel
    
    @Environment(\.theme)
    var theme
    
    var body: some View {
        HStack {
            Button(
                action: {
                    viewModel.upAction()
                },
                label: {
                    arrowView("chevron.up", isEnabled: viewModel.isUpEnabled)
                }
            )
            .disabled(!viewModel.isUpEnabled)
            
            Button(
                action: {
                    viewModel.downAction()
                },
                label: {
                    arrowView("chevron.down", isEnabled: viewModel.isDownEnabled)
                }
            )
            .disabled(!viewModel.isDownEnabled)
            
            Color.clear
                .frame(width: 20, height: 0)
            
            Text(viewModel.info)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func arrowView(_ name: String, isEnabled: Bool) -> some View {
        Image(systemName: name)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(
                isEnabled ? theme.color.primary.opacity(0.8) : .gray.opacity(0.2)
            )
    }
}

