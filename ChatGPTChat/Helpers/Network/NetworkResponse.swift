//
//  NetworkResponse.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation

// MARK: - NetworkResponse
struct NetworkResponse<T: Decodable>: Decodable {
    let results: T
}
