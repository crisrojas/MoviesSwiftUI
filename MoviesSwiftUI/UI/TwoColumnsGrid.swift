//
//  TwoColumnsGrid.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI

struct TwoColumnsGrid<Content: View, T: Identifiable>: View {
    
    let model: [T]
    let content: (T) -> Content
    
    private let columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
        
            ForEach(model) { item in
                content(item)
            }
        }
    }
}
