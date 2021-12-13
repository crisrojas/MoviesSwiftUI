//
//  GenreButton.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct CategoryButton: View {
    
    let model: Category
    
    var body: some View {
        
        model.color
            .cornerRadius(10)
            .shadow(color: model.color.opacity(0.5), radius: 10)
            .height(55)
            .overlay(label)
            .onTap(navigateTo: destination)
    }
    
    var label: Text {
        Text(model.rawValue)
            .font(.callout)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    var destination: some View {
        ListScreen(
            title: model.rawValue,
            endpoint: .genre(id: model.id)
        )
    }
}
