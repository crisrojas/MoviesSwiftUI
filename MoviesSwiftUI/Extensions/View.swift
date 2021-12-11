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
    
    func makeNavigationLink<Destination: View>(
        _ destination: Destination,
        _ isActive: Binding<Bool>
    ) -> some View {
        modifier(NavigationLinkifyModifier(isActive: isActive, destination: destination))
        
    }
    
    func onTap(perform action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            self
        }
    }
    
    func onTap<Destination: View>(navigateTo destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            self
        }
    }
    
    
    func showPerimeter(color: Color = .blue, width: CGFloat = 1) -> some View {
        self.border(color, width: width)
    }
    
    
    func maxWidth(_ value: CGFloat) -> some View {
        self.frame(maxWidth: value)
    }
    
    func maxHeight(_ value: CGFloat) -> some View {
        self.frame(maxHeight: value)
    }
    
}

struct NavigationLinkifyModifier<Destination: View>: ViewModifier {
    
    @Binding var isActive: Bool
    let destination: Destination
    
    func body(content: Content) -> some View {
        // @todo: Use native navigationLink?
        Button {
            isActive = true
            
        } label: {
            content
                .background(
                    EmptyNavigationLink(
                        destination: destination,
                        isActive: $isActive
                    )
                )
        }
    }
    
}
