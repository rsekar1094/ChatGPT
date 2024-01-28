//
//  Theme.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import Foundation
import SwiftUI


protocol Theme {
    var font: ThemeFont { get }
    var color: ThemeColor { get }
}

protocol ThemeFont {
    var headline: Font { get }
    var body: Font { get }
}

protocol ThemeColor {
    var primary: Color { get }
    var secondary: Color { get }
    var error: Color { get }
}

struct GPTTheme: Theme {
    let font: ThemeFont = CommonThemeFont()
    let color: ThemeColor = GPTThemeColor()
}

struct WhatsappTheme: Theme {
    let font: ThemeFont = CommonThemeFont()
    let color: ThemeColor = WhatsappThemeColor()
}

struct CommonThemeFont: ThemeFont {
    let headline: Font = .headline
    let body: Font = .body
}

struct GPTThemeColor: ThemeColor {
    let primary: Color = .black
    let secondary: Color = .black.opacity(0.1)
    let error: Color = .red
}

struct WhatsappThemeColor: ThemeColor {
    let primary: Color = .green
    let secondary: Color = .green.opacity(0.1)
    let error: Color = .red
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: Theme = GPTTheme()
}
