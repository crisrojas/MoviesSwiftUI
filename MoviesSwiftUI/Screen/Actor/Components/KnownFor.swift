//
//  KnownFor.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

import struct Kingfisher.KFImage

struct KnownFor: View {
    
    let knownFor: [Movie]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Known for")
                .font(.system(.headline, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
            
            ForEach(knownFor) { movie in
                
                HStack(spacing: 20) {
                    
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
            
            Text("Pic not found")
                .font(.system(.caption))
                .fontWeight(.bold)
                .foregroundColor(Color(K.textStrongColor!))
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
            
            Text(overview.prefix(65) + "...")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color(K.textSoftColor!))
                .multilineTextAlignment(.leading)
        }
    }
}
