//
//  Config.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation

// MARK: - Config
protocol Config {
    
    var apiBasePath: String { get }
    var appToken: String { get }
    var gptModel: String { get }
    
}

// MARK: - ConfigImpl
class ConfigImpl: Config {
    var apiBasePath: String { return "https://api.openai.com/v1/" }
    var appToken: String { return "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" }
    var gptModel: String { return "gpt-3.5-turbo" }
}
