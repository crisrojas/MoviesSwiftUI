//
//  View.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

// @todo: Add to @SwiftUItilities
extension View {
    
    func overlayView<Content: View>(_ content: () -> Content ) -> some View {
        self.overlay(content())
    }
}
