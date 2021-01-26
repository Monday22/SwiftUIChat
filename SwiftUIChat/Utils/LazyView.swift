//
//  LazyView.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
