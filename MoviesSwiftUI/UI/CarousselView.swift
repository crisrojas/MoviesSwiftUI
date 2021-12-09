//
//  CarousselView.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI

struct CarousselView<Content: View, T: Identifiable>: View {
    
    let model: [T]
    let spacing: CGFloat
    let content: (T) -> Content
    
    var body: some View {
        
        HStack(spacing: spacing) {
            ForEach(model) { item in
                content(item)
            }
        }
        .scrollify(.horizontal)
    }
}
