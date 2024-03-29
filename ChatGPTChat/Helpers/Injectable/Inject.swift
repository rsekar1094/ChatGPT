//
//  Inject.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation

// MARK: - Inject
@propertyWrapper
struct Inject<T> {
    let wrappedValue: T
    
    init() {
        wrappedValue = Resolver.shared.resolve()
    }
}

// MARK: - Resolver
class Resolver {
    private var storage = [String: AnyObject]()
    
    static let shared = Resolver()
    private init() {}
    
    func add<T>(_ injectable: T,key: String) {
        storage[key] = injectable as AnyObject
    }

    func resolve<T>() -> T {
        let key = String(reflecting: T.self)
        guard let injectable = storage[key] as? T else {
            fatalError("\(key) has not been added as an injectable object.")
        }
        
        return injectable
    }
}
