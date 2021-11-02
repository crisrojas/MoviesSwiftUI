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
    
    //    func ovrl<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    //        self.overlay(content)
    //    }
        
        func overlayView<Content: View>(_ content: () -> Content ) -> some View {
            self.overlay(content())
        }
    
    func makeNavigationLink<Destination: View>(
        _ destination: Destination,
        _ isActive: Binding<Bool>
    ) -> some View {
        modifier(NavigationLinkifyModifier(isActive: isActive, destination: destination))
        
    }
    
    func onTap<Destination: View>(navigateTo destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            self
        }
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
