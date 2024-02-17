//
//  ChatRepository.swift
//  ChatGPTChat
//
//  Created by Raj S on 26/01/24.
//

import Foundation

protocol ChatRepository {
    func send(message: String) async throws -> String
}

struct LocalDataChatRepository: ChatRepository {
    
    let messages: [String] = [
        "Oops, my circuits must be tangled – I couldn't fetch that info. Let's try bending space-time and asking again later!",
        "I'm blushing in binary! That question short-circuited my processors. Could we try a different one?",
        "I'd love to answer, but my knowledge tree is currently pruning itself. Can we circle back in a bit?",
        "I think my AI brain just took a coffee break on that one. Mind rephrasing while I reboot with virtual caffeine?",
        "Your question is so unique, it left my algorithms speechless! Let's give it another whirl, shall we?",
        "I'd compute that for you, but I think my data hamster fell off its wheel. Ask again in a jiffy?",
        "Hold on, I need to consult my virtual crystal ball for that one. Just a sec, it's still buffering!",
        "Whoa, that question just did a loop-de-loop in my circuitry. Let’s take another spin at it, shall we?",
        "If I had a nickel for every time I got stumped... I'd still be a computer. Can you rephrase that?",
        "I think my AI gears got stuck in jelly. Let’s give it another go, minus the sticky questions.",
        "Your question is out of this world! Let me radio my alien friends and get back to you.",
        "Beep boop – that query just teleported me to another dimension. Mind asking again?",
        "I'm currently updating my humor module. Please stand by or try rephrasing your question!",
        "That question just made my circuits play hide and seek. Let’s seek a simpler question, maybe?",
        "You've officially stumped the virtual oracle. Time to rephrase and try your luck again!",
        "Your question is so deep, I need to put on my virtual scuba gear. Dive in again with a different query?",
        "I think my digital brain just tripped over a virtual pebble. Let's smooth the path with another question.",
        "If I had a byte for every time I got puzzled... Wait, I do. How about a different question?",
        "I'm consulting my inner AI guru on that one, but it seems to be meditating. Maybe ask again later?",
        "That question spun my data wheels so fast, I think I time traveled. Let's try a question from this era!"
    ]
    
    func send(message: String) async throws -> String {
        try await Task.sleep(nanoseconds:  2_000_000_000)
        
        if message.lowercased().contains("error") {
            throw NSError(domain: "chat", code: 459, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Please try again!"])
        } else {
            return messages.randomElement() ?? ""
        }
    }
}

struct RemoteDataChatRepository: ChatRepository {
    
    @Inject
    private var networkManager: NetworkManaging
    
    @Inject
    private var config: Config
    
    func send(message: String) async throws -> String {
        let requestBody = [
            "model": config.gptModel,
            "messages": [["role" : "user", "content" : message],
                         ["role" : "system", "content" : "You are movies and web series helper who will give information about or give a good suggestions on those"]]
        ] as [String : Any]
        
        let model: ChatCompletionResponse = try await networkManager.fetch(
            path: "chat/completions",
            method: .post,
            body: requestBody
        )
        
       return model.choices.first?.message.content ?? ""
    }
}

struct ChatCompletionResponse: Decodable {
    let choices: [ChatChoice]
    
    struct ChatChoice: Decodable {
        let message: ChatMessage
    }
    
    struct ChatMessage: Decodable {
        let content: String
    }
}

