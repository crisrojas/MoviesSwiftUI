//
//  MoviesRow.swift
//  MoviesSwiftUI
//
//  Created by cristian on 22/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MoviesRow: View {
    let movie: Movie
    var body: some View {
        HStack(spacing: 24) {
     
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .overlay(ProgressView())
                }
                .cornerRadius(4)
                .frame(width: 66, height: 100)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "Unknown title")
                    .foregroundColor(Color(K.textStrongColor!))
                    .fontWeight(.heavy)
                    .font(.system(.headline, design: .rounded))

                VStack(alignment: .leading, spacing: 0) {
                    Text(movie.overview.prefix(90) + "...")
                        .fontWeight(.bold)
                    Text(movie.ratingText)
                }.font(.system(.caption, design: .rounded))
                    .foregroundColor(Color(K.textSoftColor!))
                
            }
            Spacer()
        }
    }
}

struct MoviesRow_Previews: PreviewProvider {
    static var previews: some View {
        MoviesRow(movie: Movie.localMovie)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
