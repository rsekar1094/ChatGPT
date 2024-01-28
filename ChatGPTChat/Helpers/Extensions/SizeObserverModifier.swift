//
//  SizeObserverModifier.swift
//  ChatGPTChat
//
//  Created by Raj S on 28/01/24.
//

import SwiftUI

private struct SizeObserverModifier: ViewModifier {
    
    @State
    private var frameSize: CGSize = .zero
    
    let didSizeChange: (CGSize) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { reader in
                    Color.clear
                        .preference(
                            key: SizePreferenceKey.self,
                            value: reader.size
                        )
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { newSize in
                frameSize = newSize
            }
            .onChange(of: frameSize) { _, size in
                didSizeChange(size)
            }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


extension View {
    func observeSize(
        observer: @escaping (CGSize) -> Void
    ) -> some View {
        modifier(SizeObserverModifier(didSizeChange: observer))
    }
}

