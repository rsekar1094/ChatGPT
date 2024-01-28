//
//  ChatGPTChatApp.swift
//  ChatGPTChat
//
//  Created by Raj S on 26/01/24.
//

import SwiftUI

@main
struct ChatGPTChatApp: App {
    
    init() {
        Resolver.shared.add(ConfigImpl(),key: String(reflecting: Config.self))
        Resolver.shared.add(URLSessionNetworkManager(),key: String(reflecting: NetworkManaging.self))
    }
    
    var body: some Scene {
        WindowGroup {
            ChatView(
                viewModel: .init(repository: LocalDataChatRepository())
            )
            .environment(\.theme, GPTTheme())
        }
    }
}
