//
//  PopularCarousselCard.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities


struct PopularCarouselCard: View {
    
    let image: URL?
    let title: String?
    let genres: String?
    
    var body: some View {
        
        AsyncImage(url: image) { image in
            image
                .width(350)
                .height(200)
                .aspectRatio(contentMode: .fill)
                .overlay(linearGradient)
                .overlay(titleAndGenres)
                .cornerRadius(20)
        } placeholder: {
            Rectangle()
                .fill(Color(K.primaryColor!))
                .cornerRadius(20)
                .overlayView(ProgressView.init)
        }
    }
    
    private let gradient: Gradient = Gradient(
        colors: [
            Color.black.opacity(1),
            Color.black.opacity(0.0)
        ]
    )
}

// MARK: - Sub Views
private extension PopularCarouselCard {
    
    var linearGradient: some View {
        
        LinearGradient(
            gradient: gradient,
            startPoint: .bottom,
            endPoint: .top
        )
        .height(150)
        .offset(y: 50)
    }
    
    
    var titleAndGenres: some View {
        
        DefaultVStack {
            /// @todo: Make model return a non optional String
            Text(title ?? "Unknown title")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
            
            /// @todo this is: always nil
            if let safeGenres = genres {
                Text(safeGenres)
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .opacity(0.6)
                    .top(8)
            }
            
        }
        .leading(.horizontal)
        .offset(y: 40)
        .alignX(.leading)
    }
}
