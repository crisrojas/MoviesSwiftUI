//
//  KnownFor.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct KnownForView: View {
    
    let model: [Movie]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Known for")
                .font(.system(.headline, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
            
            ForEach(model) { movie in
                
                /// @todo: Create an extension of CGfloat with a
                /// tailwind alike spacing utilities and use aross project
                HStack(alignment: .top, spacing: 20) {
                    
                    thumbnail(url: movie.posterURL)
                    overview(
                        title: movie.title ?? "Unknown title",
                        overview: movie.overview
                    )
                }
                .top(20)
                .onTap(navigateTo: DetailScreen(id: movie.id))
            }
        }
        
    }
    
    private func thumbnail(url: URL?) -> some View {
        
        AsyncImage(url: url) { image in
            
            image
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
        } placeholder: {
            
            Rectangle()
                .fill(Color(K.primaryColor!))
                .overlay(ProgressView())

        }
        .width(60)
        .height(60)
        .cornerRadius(8)
    }
    
    private func overview(
        title: String,
        overview: String
    ) -> some View {
        
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            Text(title)
                .font(.system(.headline, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color(K.textStrongColor!))
                .multilineTextAlignment(.leading)
            
            // @todo: Use linelimit(2)
            Text(overview.prefix(65) + "...")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color(K.textSoftColor!))
                .multilineTextAlignment(.leading)
        }
    }
}
